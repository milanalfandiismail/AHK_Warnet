from flask import Flask, request, render_template, redirect, url_for, session, flash
from functools import wraps
from datetime import timedelta, datetime
import os
import logging
import logging.handlers

app = Flask(__name__)
app.secret_key = 'a3f5d8e9c2b1a7f4e6d9c8b2a1f4e7d8c9b2a1f4e6d9c8b2a1f4e7d8c9b2a1f4e6d'
app.permanent_session_lifetime = timedelta(days=7)

# Konfigurasi username dan password
USERNAME = 'admin'
PASSWORD = 'billing123'

# Data dropdown
PC_LIST = ['PC-1', 'PC-2', 'PC-3', 'PC-4', 'PC-5', 'PC-6', 'PC-7', 'PC-8', 'PC-9', 'PC-10', 'PC-11', 'PC-12', 'PC-13', 'PC-14', 'PC-15', 'PC-16', 'PC-17', 'PC-18', 'PC-19']
WAKTU_LIST = ["1", "2", "3", "4", "10"]
AKSI_LIST = ['Buka Paket', 'Tambah Waktu', 'Tutup Billing']

# ==================== KONFIGURASI LOGGING ====================
LOG_DIR = r'C:\logs'
if not os.path.exists(LOG_DIR):
    os.makedirs(LOG_DIR)

class DailySectionFormatter(logging.Formatter):
    """Custom formatter yang nambah section [TANGGAL] setiap hari baru"""
    
    def __init__(self):
        super().__init__()
        self.current_date = None
        self.first_log = True
    
    def format(self, record):
        # Ambil tanggal dari record
        record_date = datetime.fromtimestamp(record.created).strftime('%Y-%m-%d')
        
        # Format waktu
        record_time = datetime.fromtimestamp(record.created).strftime('%H:%M:%S')
        
        # Kalo tanggal berubah atau first log, tambah section
        if self.current_date != record_date or self.first_log:
            self.current_date = record_date
            self.first_log = False
            section_header = f"\n[{record_date}]\n"
        else:
            section_header = ""
        
        # Format pesan: HH:MM:SS | LEVEL | MESSAGE
        log_level = record.levelname
        log_message = record.getMessage()
        
        return f"{section_header}{record_time} | {log_level:7} | {log_message}"

# Setup logger
logger = logging.getLogger('TmBilling')
logger.setLevel(logging.INFO)

# Handler untuk file
log_file = os.path.join(LOG_DIR, 'billing.log')
file_handler = logging.FileHandler(log_file, mode='a', encoding='utf-8')
file_handler.setFormatter(DailySectionFormatter())
logger.addHandler(file_handler)

# Optional: Handler untuk console (debug)
console_handler = logging.StreamHandler()
console_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))
logger.addHandler(console_handler)

# ==================== FUNGSI LOGGING ====================
def log_success(message):
    """Log level SUCCESS (kita custom pake INFO)"""
    logger.info(f"✅ {message}")

def log_error(message):
    """Log level ERROR"""
    logger.error(f"❌ {message}")

def log_warning(message):
    """Log level WARNING"""
    logger.warning(f"⚠️ {message}")

# ==================== ROUTES ====================
@app.before_request
def make_session_permanent():
    session.permanent = True

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'logged_in' not in session:
            log_warning(f"Unauthorized access attempt to {request.path}")
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form.get('username', '')
        password = request.form.get('password', '')
        
        if username == USERNAME and password == PASSWORD:
            session['logged_in'] = True
            log_success(f"Login berhasil: {username} dari {request.remote_addr}")
            return redirect(url_for('index'))
        else:
            error = 'Username atau password salah'
            log_warning(f"Login gagal: {username} dari {request.remote_addr}")
    
    return render_template('login.html', error=error)

@app.route('/logout')
def logout():
    username = "Unknown"
    if 'logged_in' in session:
        log_success("Logout berhasil")
    session.pop('logged_in', None)
    flash('Logout berhasil!', 'success')
    return redirect(url_for('login'))

@app.route('/', methods=['GET', 'POST'])
@login_required
def index():
    if request.method == 'POST':
        pc = request.form.get('pc')
        waktu = request.form.get('waktu')
        aksi = request.form.get('aksi')
        
        if pc and waktu and aksi:
            data = f"{pc}|{waktu}|{aksi}"
            try:
                with open(r'C:\trigger.txt', 'w') as f:
                    f.write(data)
                
                # Log berdasarkan aksi
                if waktu == "tutup" or aksi == "Tutup Billing":
                    log_success(f"{pc} | Melakukan Tutup Billing")
                    flash("Berhasil", 'success')
                    flash(f"{pc}", 'success')
                    flash("Melakukan Tutup Billing", 'success')
                else:
                    log_success(f"{pc} | {aksi} | {waktu} Jam")
                    flash("Berhasil", 'success')
                    flash(f"{pc}", 'success')
                    flash(f"Waktu {waktu} Jam", 'success')
                    flash(f"{aksi}", 'success')
                    
            except Exception as e:
                error_msg = f"Gagal menulis file trigger: {str(e)}"
                log_error(error_msg)
                flash(f"Gagal menulis file: {e}", 'error')
        else:
            log_warning("Form tidak lengkap di halaman index")
            flash("Semua field harus diisi!", 'error')
            
        return redirect(url_for('index'))
    
    return render_template('index.html', 
                           pc_list=PC_LIST, 
                           waktu_list=WAKTU_LIST, 
                           aksi_list=AKSI_LIST)

@app.route('/member', methods=['GET', 'POST'])
@login_required
def member():
    WaktuMember_List = ["1 Jam", "2 Jam", "3 Jam", "4 Jam", "10 Jam"]
    
    if request.method == 'POST':
        nama_member = request.form.get('nama_member', '').strip()
        waktu_member = request.form.get('waktu_member', '').strip()
        
        if nama_member and waktu_member:
            data_member = f"{nama_member}|{waktu_member}"
            try:
                with open(r'C:\member.txt', 'w') as f:
                    f.write(data_member)
                
                log_success(f"Member | {nama_member} | {waktu_member}")
                flash("Berhasil", 'success')
                flash(f"{nama_member} - {waktu_member}", 'success')
                
            except Exception as e:
                error_msg = f"Gagal menulis file member: {str(e)}"
                log_error(error_msg)
                flash(f"Gagal menulis file: {e}", 'error')
        else:
            log_warning("Form member tidak lengkap")
            flash("Nama member dan waktu harus diisi!", 'error')
            
        return redirect(url_for('member'))
    
    return render_template("member.html", WaktuMember_List=WaktuMember_List)

# ==================== ROUTE UNTUK LIHAT LOG ====================
@app.route('/logs')
@login_required
def view_logs():
    """Lihat isi file log (opsional)"""
    log_file = os.path.join(LOG_DIR, 'billing.log')
    logs = ""
    
    if os.path.exists(log_file):
        with open(log_file, 'r', encoding='utf-8') as f:
            logs = f.read()
    
    return f"<pre>{logs}</pre>"

@app.route('/logs/today')
@login_required
def view_today_logs():
    """Lihat log hari ini aja"""
    log_file = os.path.join(LOG_DIR, 'billing.log')
    today = datetime.now().strftime('%Y-%m-%d')
    today_logs = []
    
    if os.path.exists(log_file):
        with open(log_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        in_today_section = False
        for line in lines:
            if line.startswith(f'[{today}]'):
                in_today_section = True
                today_logs.append(line)
            elif line.startswith('[') and in_today_section:
                break
            elif in_today_section:
                today_logs.append(line)
    
    return f"<pre>{''.join(today_logs)}</pre>"

if __name__ == '__main__':
    log_success("=== APLIKASI TмBILLING DIMULAI ===")
    app.run(host='0.0.0.0', port=5003, debug=True)