// Session Timeout Handler
class SessionTimeoutHandler {
    constructor() {
        this.warningTime = 9 * 60 * 1000; // 9 minutes (1 minute before timeout)
        this.timeoutTime = 10 * 60 * 1000; // 10 minutes (matches server configuration)
        this.warningShown = false;
        this.warningModal = null;
        this.countdownInterval = null;
        
        this.init();
    }
    
    init() {
        // Create warning modal
        this.createWarningModal();
        
        // Start session monitoring
        this.startSessionMonitoring();
        
        // Add activity listeners
        this.addActivityListeners();
    }
    
    createWarningModal() {
        const modalHtml = `
            <div class="modal fade" id="sessionTimeoutModal" tabindex="-1" aria-labelledby="sessionTimeoutModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="sessionTimeoutModalLabel">Session Timeout Warning</h5>
                        </div>
                        <div class="modal-body">
                            <p>Your session will expire in <span id="countdown">60</span> seconds.</p>
                            <p>Click "Continue Session" to stay logged in, or you will be automatically logged out.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="continueSession">Continue Session</button>
                            <button type="button" class="btn btn-secondary" id="logoutNow">Logout Now</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        document.body.insertAdjacentHTML('beforeend', modalHtml);
        this.warningModal = new bootstrap.Modal(document.getElementById('sessionTimeoutModal'));
        
        // Add event listeners
        document.getElementById('continueSession').addEventListener('click', () => this.continueSession());
        document.getElementById('logoutNow').addEventListener('click', () => this.logoutNow());
    }
    
    startSessionMonitoring() {
        let lastActivity = Date.now();
        
        setInterval(() => {
            const currentTime = Date.now();
            const timeSinceLastActivity = currentTime - lastActivity;
            
            if (timeSinceLastActivity >= this.timeoutTime) {
                // Session expired, redirect to login
                this.redirectToLogin('expired');
            } else if (timeSinceLastActivity >= this.warningTime && !this.warningShown) {
                // Show warning
                this.showWarning();
            }
        }, 1000); // Check every second
    }
    
    showWarning() {
        if (this.warningShown) return;
        
        this.warningShown = true;
        let countdown = 60; // 60 seconds countdown
        
        // Update countdown
        this.countdownInterval = setInterval(() => {
            countdown--;
            const countdownElement = document.getElementById('countdown');
            if (countdownElement) {
                countdownElement.textContent = countdown;
            }
            
            if (countdown <= 0) {
                clearInterval(this.countdownInterval);
                this.redirectToLogin('expired');
            }
        }, 1000);
        
        // Show modal
        this.warningModal.show();
    }
    
    continueSession() {
        // Hide modal
        this.warningModal.hide();
        this.warningShown = false;
        
        // Clear countdown
        if (this.countdownInterval) {
            clearInterval(this.countdownInterval);
        }
        
        // Send heartbeat to server to extend session
        this.sendHeartbeat();
        
        // Reset activity time
        this.resetActivityTime();
    }
    
    logoutNow() {
        // Hide modal
        this.warningModal.hide();
        
        // Clear countdown
        if (this.countdownInterval) {
            clearInterval(this.countdownInterval);
        }
        
        // Redirect to logout
        this.redirectToLogin('logout');
    }
    
    sendHeartbeat() {
        // Send a request to extend the session
        fetch('/swarajtraders/heartbeat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            credentials: 'same-origin'
        }).catch(error => {
            console.log('Heartbeat failed:', error);
        });
    }
    
    resetActivityTime() {
        // Reset the last activity time
        this.lastActivity = Date.now();
    }
    
    addActivityListeners() {
        const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart', 'click'];
        
        events.forEach(event => {
            document.addEventListener(event, () => {
                this.resetActivityTime();
            });
        });
    }
    
    redirectToLogin(reason) {
        const baseUrl = '/swarajtraders/login';
        const url = reason ? `${baseUrl}?${reason}` : baseUrl;
        window.location.href = url;
    }
}

// Initialize session timeout handler when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new SessionTimeoutHandler();
});
