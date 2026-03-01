from flask import Flask, request, render_template, redirect, url_for, session, flash
from functools import wraps
from datetime import timedelta
import os

app = Flask(__name__)
app.secret_key = 'a3f5d8e9c2b1a7f4e6d9c8b2a1f4e7d8c9b2a1f4e6d9c8b2a1f4e7d8c9b2a1f4e6d'
app.permanent_session_lifetime = timedelta(days=7)

# Konfigurasi username dan password (hardcoded untuk sederhana)
USERNAME = 'admin'
PASSWORD = 'billing123'

# Data dropdown (sesuai kebutuhan)
PC_LIST = ['PC-1', 'PC-2', 'PC-3', 'PC-4', 'PC-5', 'PC-6', 'PC-7', 'PC-8', 'PC-9', 'PC-10', 'PC-11', 'PC-12', 'PC-13', 'PC-14', 'PC-15', 'PC-16', 'PC-17', 'PC-18', 'PC-19']
WAKTU_LIST = ["1", "2", "3", "4", "10"]
AKSI_LIST = ['Buka Paket', 'Tambah Waktu', 'Tutup Billing']

@app.before_request
def make_session_permanent():
    session.permanent = True  # Aktifkan session permanent

# Decorator untuk memeriksa login
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'logged_in' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if username == USERNAME and password == PASSWORD:
            session['logged_in'] = True
            return redirect(url_for('index'))
        else:
            error = 'Username atau password salah'
    return render_template('login.html', error=error)

@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('Logout berhasil!', 'success')
    return redirect(url_for('login'))

@app.route('/', methods=['GET', 'POST'])
@login_required
def index():
    if request.method == 'POST':
        pc = request.form['pc']
        waktu = request.form['waktu']
        aksi = request.form['aksi']
        if pc and waktu and aksi:
            data = f"{pc}|{waktu}|{aksi}"
            try:
                # Ganti path file trigger sesuai kebutuhan
                with open(r'C:\trigger.txt', 'w') as f:
                    f.write(data)
                flash("Berhasil", 'success')
                flash(f"{pc}", 'success')
                flash(f"Waktu {waktu} Jam", 'success')
                flash(f"{aksi}", 'success')
            except Exception as e:
                flash(f"Gagal menulis file: {e}", 'error')
        # Redirect ke halaman yang sama (GET)
        return redirect(url_for('index'))
    
    return render_template('index.html', 
                           pc_list=PC_LIST, 
                           waktu_list=WAKTU_LIST, 
                           aksi_list=AKSI_LIST)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)