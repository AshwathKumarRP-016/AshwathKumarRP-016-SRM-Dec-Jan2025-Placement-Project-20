<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Registration | Complaint Management System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="style.css">
    
    <style>
        /* Additional inline styles for specific adjustments */
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-bottom: 60px;
        }
        
        .navbar {
            backdrop-filter: blur(10px);
            background: rgba(44, 62, 80, 0.95) !important;
        }
        
        .complaint-icon {
            font-size: 3rem;
            color: #3498db;
            margin-bottom: 1rem;
        }
        
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
            padding: 0;
        }
        
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            flex: 1;
            position: relative;
        }
        
        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #ecf0f1;
            color: #7f8c8d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-bottom: 0.5rem;
            z-index: 2;
        }
        
        .step.active .step-number {
            background: #3498db;
            color: white;
            box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.2);
        }
        
        .step-label {
            font-size: 0.85rem;
            color: #7f8c8d;
            text-align: center;
        }
        
        .step.active .step-label {
            color: #3498db;
            font-weight: 600;
        }
        
        .step:not(:last-child)::after {
            content: '';
            position: absolute;
            top: 20px;
            left: 50%;
            width: 100%;
            height: 2px;
            background: #ecf0f1;
            z-index: 1;
        }
        
        .form-section {
            display: none;
        }
        
        .form-section.active {
            display: block;
            animation: fadeIn 0.5s ease-out;
        }
        
        .character-count {
            font-size: 0.85rem;
            color: #7f8c8d;
            text-align: right;
            margin-top: 0.25rem;
        }
        
        .btn-group-custom {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .complaint-preview {
            background: #f8f9fa;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-top: 1.5rem;
            border-left: 4px solid #3498db;
        }
        
        .complaint-preview h6 {
            color: #2c3e50;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #dee2e6;
        }
        
        .complaint-preview p {
            margin-bottom: 0.5rem;
        }
        
        .complaint-preview .label {
            font-weight: 600;
            color: #2c3e50;
            min-width: 120px;
            display: inline-block;
        }
        
        .form-check-label {
            font-weight: 500;
        }
        
        .form-check-input:checked {
            background-color: #3498db;
            border-color: #3498db;
        }
        
        /* Required field indicator */
        .required-field::after {
            content: " *";
            color: #dc3545;
        }
        
        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fade-in {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-comments me-2"></i>
            <span>Complaint Management System</span>
        </a>
        <div class="d-flex align-items-center">
            <span class="text-white me-3 d-none d-md-block">
                <i class="fas fa-user-circle me-1"></i>
                Welcome, User
            </span>
            <a href="viewStatus.jsp" class="btn btn-outline-light btn-sm">
                <i class="fas fa-list-alt me-1"></i> View Status
            </a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-5 pt-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-lg border-0">
                <div class="card-header text-center py-4">
                    <div class="complaint-icon">
                        <i class="fas fa-exclamation-circle"></i>
                    </div>
                    <h3 class="card-title mb-0">Register New Complaint</h3>
                    <p class="text-muted mb-0">Fill out the form below to submit your complaint</p>
                </div>
                
                <!-- Step Indicator -->
                <div class="px-4 pt-4">
                    <div class="step-indicator">
                        <div class="step active">
                            <div class="step-number">1</div>
                            <div class="step-label">Complaint Details</div>
                        </div>
                        <div class="step">
                            <div class="step-number">2</div>
                            <div class="step-label">Additional Info</div>
                        </div>
                        <div class="step">
                            <div class="step-number">3</div>
                            <div class="step-label">Review & Submit</div>
                        </div>
                    </div>
                </div>
                
                <div class="card-body p-4">
                    <form id="complaintForm" action="ComplaintServlet" method="post">
                        
                        <!-- Step 1: Complaint Details -->
                        <div class="form-section active" id="step1">
                            <h5 class="mb-4 text-primary">
                                <i class="fas fa-info-circle me-2"></i>Complaint Information
                            </h5>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="fullName" class="form-label required-field">
                                        <i class="fas fa-user me-1"></i>Full Name
                                    </label>
                                    <input type="text" class="form-control" id="fullName" name="name" 
                                           placeholder="Enter your full name" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-1"></i>Email Address
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           placeholder="Enter your email">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="complaintTitle" class="form-label required-field">
                                    <i class="fas fa-heading me-1"></i>Complaint Title
                                </label>
                                <input type="text" class="form-control" id="complaintTitle" name="title" 
                                       placeholder="Brief description of your complaint" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="complaintDescription" class="form-label required-field">
                                    <i class="fas fa-file-alt me-1"></i>Complaint Description
                                </label>
                                <textarea class="form-control" id="complaintDescription" name="complaint" 
                                          rows="4" placeholder="Please provide detailed information about your complaint..." 
                                          required></textarea>
                                <div class="character-count">
                                    <span id="charCount">0</span> / 1000 characters
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-tags me-1"></i>Complaint Category
                                </label>
                                <select class="form-select" name="category" id="category">
                                    <option value="" selected>Select a category</option>
                                    <option value="service">Service Issue</option>
                                    <option value="billing">Billing/Invoice</option>
                                    <option value="technical">Technical Problem</option>
                                    <option value="delivery">Delivery/Shipping</option>
                                    <option value="quality">Quality Concern</option>
                                    <option value="other">Other</option>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Step 2: Additional Information -->
                        <div class="form-section" id="step2">
                            <h5 class="mb-4 text-primary">
                                <i class="fas fa-plus-circle me-2"></i>Additional Information
                            </h5>
                            
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-calendar me-1"></i>Incident Date
                                </label>
                                <input type="date" class="form-control" name="incidentDate" id="incidentDate">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-phone me-1"></i>Contact Number
                                </label>
                                <input type="tel" class="form-control" name="phone" id="phone"
                                       placeholder="Enter your contact number">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-flag me-1"></i>Priority Level
                                </label>
                                <div class="d-flex gap-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="priority" id="low" value="low" checked>
                                        <label class="form-check-label" for="low">
                                            <span class="badge bg-success">Low</span>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="priority" id="medium" value="medium">
                                        <label class="form-check-label" for="medium">
                                            <span class="badge bg-warning">Medium</span>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="priority" id="high" value="high">
                                        <label class="form-check-label" for="high">
                                            <span class="badge bg-danger">High</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-paperclip me-1"></i>Attachments (Optional)
                                </label>
                                <input type="file" class="form-control" name="attachment" accept=".pdf,.jpg,.png,.doc">
                                <small class="text-muted">Max file size: 5MB. Supported formats: PDF, JPG, PNG, DOC</small>
                            </div>
                        </div>
                        
                        <!-- Step 3: Review and Submit -->
                        <div class="form-section" id="step3">
                            <h5 class="mb-4 text-primary">
                                <i class="fas fa-check-circle me-2"></i>Review & Submit
                            </h5>
                            
                            <div class="complaint-preview">
                                <h6><i class="fas fa-eye me-1"></i>Complaint Preview</h6>
                                <p><span class="label">Name:</span> <span id="previewName"></span></p>
                                <p><span class="label">Email:</span> <span id="previewEmail"></span></p>
                                <p><span class="label">Title:</span> <span id="previewTitle"></span></p>
                                <p><span class="label">Category:</span> <span id="previewCategory"></span></p>
                                <p><span class="label">Priority:</span> <span id="previewPriority"></span></p>
                                <p><span class="label">Description:</span> <span id="previewDescription"></span></p>
                            </div>
                            
                            <div class="form-check mt-4">
                                <input class="form-check-input" type="checkbox" id="terms" required>
                                <label class="form-check-label" for="terms">
                                    I confirm that the information provided is accurate and I agree to the 
                                    <a href="#" class="text-decoration-none">terms and conditions</a>.
                                </label>
                            </div>
                        </div>
                        
                        <!-- Navigation Buttons -->
                        <div class="btn-group-custom">
                            <button type="button" class="btn btn-outline-secondary" id="prevBtn" style="display: none;">
                                <i class="fas fa-arrow-left me-1"></i> Previous
                            </button>
                            <button type="button" class="btn btn-primary ms-auto" id="nextBtn">
                                Next <i class="fas fa-arrow-right ms-1"></i>
                            </button>
                            <button type="submit" class="btn btn-success" id="submitBtn" style="display: none;">
                                <i class="fas fa-paper-plane me-1"></i> Submit Complaint
                            </button>
                        </div>
                    </form>
                </div>
                
                <div class="card-footer text-center py-3 bg-light">
                    <small class="text-muted">
                        <i class="fas fa-shield-alt me-1"></i>
                        Your information is secure and will be handled confidentially
                    </small>
                </div>
            </div>
            
            <!-- Support Info -->
            <div class="text-center mt-4">
                <p class="text-muted">
                    <i class="fas fa-question-circle me-1"></i>
                    Need help? Contact support at 
                    <a href="mailto:support@complaintsystem.com" class="text-decoration-none">support@complaintsystem.com</a>
                    or call <strong>1-800-COMPLAINT</strong>
                </p>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Form Handling Script -->
<script>
    // Wait for DOM to be fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize variables
        let currentStep = 1;
        const totalSteps = 3;
        
        // Get DOM elements
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const submitBtn = document.getElementById('submitBtn');
        const formSections = document.querySelectorAll('.form-section');
        const stepIndicators = document.querySelectorAll('.step');
        
        // Character counter setup
        const descriptionTextarea = document.getElementById('complaintDescription');
        const charCount = document.getElementById('charCount');
        
        if (descriptionTextarea && charCount) {
            descriptionTextarea.addEventListener('input', function() {
                charCount.textContent = this.value.length;
            });
            // Initialize character count
            charCount.textContent = descriptionTextarea.value.length;
        }
        
        // Next button click handler
        nextBtn.addEventListener('click', function() {
            if (validateCurrentStep()) {
                if (currentStep < totalSteps) {
                    // Move to next step
                    goToStep(currentStep + 1);
                }
            }
        });
        
        // Previous button click handler
        prevBtn.addEventListener('click', function() {
            if (currentStep > 1) {
                // Move to previous step
                goToStep(currentStep - 1);
            }
        });
        
        // Function to navigate to a specific step
        function goToStep(stepNumber) {
            // Hide current step
            formSections[currentStep - 1].classList.remove('active');
            stepIndicators[currentStep - 1].classList.remove('active');
            
            // Show target step
            formSections[stepNumber - 1].classList.add('active');
            stepIndicators[stepNumber - 1].classList.add('active');
            
            // Update current step
            currentStep = stepNumber;
            
            // Update button visibility
            updateButtonVisibility();
            
            // Update preview if on step 3
            if (currentStep === 3) {
                updatePreview();
            }
        }
        
        // Function to update button visibility based on current step
        function updateButtonVisibility() {
            if (currentStep === 1) {
                // First step: only show Next button
                prevBtn.style.display = 'none';
                nextBtn.style.display = 'inline-block';
                submitBtn.style.display = 'none';
            } else if (currentStep === totalSteps) {
                // Last step: show Previous and Submit buttons
                prevBtn.style.display = 'inline-block';
                nextBtn.style.display = 'none';
                submitBtn.style.display = 'inline-block';
            } else {
                // Middle step: show both Previous and Next buttons
                prevBtn.style.display = 'inline-block';
                nextBtn.style.display = 'inline-block';
                submitBtn.style.display = 'none';
            }
        }
        
        // Function to validate the current step
        function validateCurrentStep() {
            if (currentStep === 1) {
                return validateStep1();
            } else if (currentStep === 2) {
                return validateStep2();
            }
            return true;
        }
        
        // Function to validate step 1
        function validateStep1() {
            const fullName = document.getElementById('fullName').value.trim();
            const complaintTitle = document.getElementById('complaintTitle').value.trim();
            const complaintDescription = document.getElementById('complaintDescription').value.trim();
            
            // Reset any previous error states
            document.getElementById('fullName').classList.remove('is-invalid');
            document.getElementById('complaintTitle').classList.remove('is-invalid');
            document.getElementById('complaintDescription').classList.remove('is-invalid');
            
            let isValid = true;
            
            // Validate full name
            if (!fullName) {
                document.getElementById('fullName').classList.add('is-invalid');
                alert('Please enter your full name');
                document.getElementById('fullName').focus();
                isValid = false;
            }
            
            // Validate complaint title
            if (!complaintTitle) {
                document.getElementById('complaintTitle').classList.add('is-invalid');
                if (isValid) {
                    alert('Please enter a complaint title');
                    document.getElementById('complaintTitle').focus();
                }
                isValid = false;
            }
            
            // Validate complaint description
            if (!complaintDescription) {
                document.getElementById('complaintDescription').classList.add('is-invalid');
                if (isValid) {
                    alert('Please enter a complaint description');
                    document.getElementById('complaintDescription').focus();
                }
                isValid = false;
            } else if (complaintDescription.length < 10) {
                document.getElementById('complaintDescription').classList.add('is-invalid');
                if (isValid) {
                    alert('Please provide a more detailed description (at least 10 characters)');
                    document.getElementById('complaintDescription').focus();
                }
                isValid = false;
            }
            
            return isValid;
        }
        
        // Function to validate step 2 (optional validation)
        function validateStep2() {
            // Step 2 fields are optional, so always return true
            return true;
        }
        
        // Function to update the preview in step 3
        function updatePreview() {
            // Get values from step 1
            const fullName = document.getElementById('fullName').value || 'Not provided';
            const email = document.getElementById('email').value || 'Not provided';
            const complaintTitle = document.getElementById('complaintTitle').value || 'Not provided';
            const complaintDescription = document.getElementById('complaintDescription').value || 'Not provided';
            
            // Get category
            const categorySelect = document.getElementById('category');
            const category = categorySelect.options[categorySelect.selectedIndex].text;
            
            // Get priority
            let priority = 'Low';
            if (document.getElementById('medium').checked) {
                priority = 'Medium';
            } else if (document.getElementById('high').checked) {
                priority = 'High';
            }
            
            // Update preview elements
            document.getElementById('previewName').textContent = fullName;
            document.getElementById('previewEmail').textContent = email || 'Not provided';
            document.getElementById('previewTitle').textContent = complaintTitle;
            document.getElementById('previewCategory').textContent = category;
            document.getElementById('previewPriority').textContent = priority;
            
            // Truncate description if too long
            const truncatedDescription = complaintDescription.length > 200 
                ? complaintDescription.substring(0, 200) + '...' 
                : complaintDescription;
            document.getElementById('previewDescription').textContent = truncatedDescription;
        }
        
        // Form submission handler
        document.getElementById('complaintForm').addEventListener('submit', function(e) {
            // Check if terms are accepted (only for step 3)
            if (currentStep === 3) {
                const termsCheckbox = document.getElementById('terms');
                if (!termsCheckbox.checked) {
                    e.preventDefault();
                    alert('Please accept the terms and conditions');
                    termsCheckbox.focus();
                    return;
                }
                
                // Confirm submission
                const confirmSubmit = confirm('Are you sure you want to submit this complaint?');
                if (!confirmSubmit) {
                    e.preventDefault();
                }
            } else {
                // Prevent form submission if not on step 3
                e.preventDefault();
            }
        });
        
        // Initialize button visibility
        updateButtonVisibility();
        
        // Add CSS for validation
        const style = document.createElement('style');
        style.textContent = `
            .is-invalid {
                border-color: #dc3545 !important;
            }
            .is-invalid:focus {
                box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25) !important;
            }
        `;
        document.head.appendChild(style);
    });
</script>

</body>
</html>