# Bandar Kopi V3.4 — Cloud Ready

V3.4 memindahkan data produksi dari `data.json` ke PostgreSQL jika `DATABASE_URL` tersedia. Tanpa `DATABASE_URL`, aplikasi tetap bisa dijalankan lokal untuk demo.

## Jalur yang disiapkan
Render dapat menjalankan Node.js Web Service dan managed PostgreSQL. Render juga mendukung health check dan environment variables. Jangan memakai resource gratis untuk operasional produksi tanpa meninjau batasannya; dokumentasi Render menyebut free Postgres dapat berakhir setelah 30 hari. citeturn0search4turn0search6

### Cara deploy di Render
1. Masukkan folder ini ke repository GitHub.
2. Di Render pilih **New → Blueprint** lalu pilih repository.
3. Render akan membaca `render.yaml` dan membuat Web Service + PostgreSQL.
4. Isi `PUBLIC_BASE_URL` dengan URL HTTPS aplikasi setelah URL Render tersedia.
5. Isi `PAYMENT_WEBHOOK_SECRET` dengan secret acak panjang melalui Environment Variables.
6. Setelah database dibuat, buka Shell/terminal service dan jalankan `npm run migrate` sekali untuk membuat tabel + akun demo.
7. Buka `/health`; harus menjawab `ok:true` dan `database:true`.

Render mendukung deploy dari Git dan redeploy otomatis ketika branch yang terhubung berubah. citeturn0search8

## Akun demo setelah migrasi
- owner / owner123
- kasir / kasir123
- barista / barista123
- customer / customer123

**Segera ganti password sebelum dipakai nyata.**

## PostgreSQL
`schema.sql` membuat tabel users, products, tables, orders, payments, dan user_sessions. Render menyediakan managed PostgreSQL dan koneksi terenkripsi untuk koneksi eksternal. citeturn0search0turn0search15

## QR meja
QR lama dari V3.3 tetap memakai token `BK-1` sampai `BK-12`. Setelah domain produksi final, buat QR yang menunjuk ke:
`https://DOMAIN/?table_token=BK-1`

Jangan mencetak QR final sebelum domain produksi ditetapkan.

## QRIS / pembayaran
V3.4 menyiapkan field `payment` dan `payment_status` serta tabel `payments`. Ini **belum** mengaktifkan merchant QRIS/provider nyata. Secret provider harus disimpan sebagai environment variable dan status pembayaran harus ditentukan server/webhook provider, bukan browser pelanggan.

## Keamanan
- Session cookie HttpOnly, SameSite=Lax, Secure saat production.
- Password otomatis dimigrasikan dari SHA-256 demo ke scrypt setelah login.
- Rate limit login dasar.
- Security headers.
- Origin check untuk request mutasi.
- Database tidak menyimpan kredensial provider di source code.

## Catatan penting
Jangan menganggap aplikasi sudah online hanya karena paket ini siap. Deployment nyata tetap membutuhkan repository/provider cloud, database yang aktif, dan environment variables. Jangan mengirim password, API secret, atau private key melalui chat.
