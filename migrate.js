const fs=require('fs'),path=require('path'),crypto=require('crypto');
const {Pool}=require('pg');
const url=process.env.DATABASE_URL;
if(!url){console.error('DATABASE_URL belum diisi');process.exit(1)}
const pool=new Pool({connectionString:url,ssl:process.env.NODE_ENV==='production'?{rejectUnauthorized:false}:undefined});
const hash=p=>crypto.createHash('sha256').update(String(p)).digest('hex');
const sql=fs.readFileSync(path.join(__dirname,'schema.sql'),'utf8');
(async()=>{const c=await pool.connect();try{await c.query(sql);await c.query(`INSERT INTO users (id,name,username,password,role) VALUES ($1,$2,$3,$4,$5),($6,$7,$8,$9,$10),($11,$12,$13,$14,$15),($16,$17,$18,$19,$20) ON CONFLICT (username) DO NOTHING`,['u1','Owner Bandar','owner',hash('owner123'),'owner','u2','Kasir Bandar','kasir',hash('kasir123'),'cashier','u3','Barista Bandar','barista',hash('barista123'),'barista','u4','Pelanggan Demo','customer',hash('customer123'),'customer']);
for(let i=1;i<=12;i++) await c.query(`INSERT INTO tables (id,name,status,qr_token) VALUES ($1,$2,'available',$3) ON CONFLICT (id) DO NOTHING`,['t'+i,'Meja '+String(i).padStart(2,'0'),'BK-'+i]);
const products=[['p1','Kopi Susu Bandar',18000,'Kopi'],['p2','Americano',15000,'Kopi'],['p3','Cappuccino',20000,'Kopi'],['p4','Matcha Latte',22000,'Non-Kopi'],['p5','Croissant',16000,'Makanan']];
for(const p of products) await c.query(`INSERT INTO products (id,name,price,category) VALUES ($1,$2,$3,$4) ON CONFLICT (id) DO NOTHING`,p);
console.log('Migrasi + seed berhasil.');}finally{c.release();await pool.end()}})().catch(e=>{console.error(e);process.exit(1)})
