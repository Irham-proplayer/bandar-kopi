# Backup & keamanan V3.2

1. Backup database PostgreSQL secara berkala (harian untuk produksi).
2. Simpan backup di lokasi berbeda dari server utama.
3. Jangan menyimpan password asli; gunakan Argon2id/scrypt/bcrypt di produksi.
4. Gunakan HTTPS.
5. Ganti SESSION_SECRET dan semua kredensial demo sebelum publikasi.
6. Batasi akses endpoint admin/owner dengan role.
7. Tambahkan rate limit untuk login.
8. Verifikasi signature webhook payment gateway.
9. Catat audit log untuk perubahan status, refund, dan perubahan harga.
