CREATE TABLE IF NOT EXISTS users (id text PRIMARY KEY,name text NOT NULL,username text UNIQUE NOT NULL,password text NOT NULL,role text NOT NULL CHECK(role IN ('owner','cashier','barista','customer')),created_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS products (id text PRIMARY KEY,name text NOT NULL,price numeric(14,2) NOT NULL,category text NOT NULL,active boolean NOT NULL DEFAULT true,created_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS tables (id text PRIMARY KEY,name text NOT NULL,status text NOT NULL DEFAULT 'available',qr_token text UNIQUE NOT NULL);
CREATE TABLE IF NOT EXISTS orders (id text PRIMARY KEY,customer_id text REFERENCES users(id),customer_name text NOT NULL,table_id text REFERENCES tables(id),table_name text NOT NULL,items jsonb NOT NULL,total numeric(14,2) NOT NULL,status text NOT NULL,payment text NOT NULL DEFAULT 'CASH',payment_status text NOT NULL DEFAULT 'UNPAID',created_at timestamptz NOT NULL DEFAULT now(),updated_at timestamptz);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE TABLE IF NOT EXISTS payments (id bigserial PRIMARY KEY,order_id text UNIQUE REFERENCES orders(id) ON DELETE CASCADE,provider text NOT NULL,reference text,amount numeric(14,2) NOT NULL,status text NOT NULL DEFAULT 'PENDING',raw jsonb,created_at timestamptz NOT NULL DEFAULT now(),updated_at timestamptz NOT NULL DEFAULT now());

CREATE TABLE IF NOT EXISTS user_sessions (token text PRIMARY KEY,user_id text NOT NULL REFERENCES users(id) ON DELETE CASCADE,created_at timestamptz NOT NULL DEFAULT now());
CREATE INDEX IF NOT EXISTS idx_sessions_created_at ON user_sessions(created_at);
