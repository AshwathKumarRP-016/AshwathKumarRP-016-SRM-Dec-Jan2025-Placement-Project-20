# **Complaint Management System**

## **📋 Project Overview**
A comprehensive Java-based web application for managing customer complaints with a modern, user-friendly interface. This system allows users to submit complaints and track their resolution status in real-time.

## **🎯 Features**

### **User Features:**
- ✅ **Complaint Submission**: Easy-to-use form for filing complaints
- ✅ **Status Tracking**: Real-time tracking with visual progress indicators
- ✅ **Ticket Generation**: Automatic unique ticket ID generation
- ✅ **Category-based Complaints**: Organized complaint categorization
- ✅ **Priority Levels**: Four priority levels (Low, Medium, High, Urgent)
- ✅ **Responsive UI**: Modern, intuitive interface with smooth animations

### **Admin Features:**
- ✅ **Dashboard**: Overview of all complaints
- ✅ **Status Management**: Update complaint status
- ✅ **CRUD Operations**: Full Create, Read, Update, Delete functionality
- ✅ **Database Integration**: MySQL backend with proper connection pooling

## **🛠️ Technologies Used**

### **Backend:**
- **Java**: Core programming language
- **Servlets**: Request handling and processing
- **JSP (JavaServer Pages)**: Dynamic web content
- **JDBC**: Database connectivity
- **MySQL**: Relational database management

### **Frontend:**
- **HTML5**: Semantic markup
- **CSS3**: Modern styling with animations
- **JavaScript**: Client-side interactivity
- **Font Awesome**: Icons and visual elements
- **Responsive Design**: Mobile-friendly interface

### **Tools & Libraries:**
- **Apache Tomcat**: Application server
- **Eclipse IDE**: Development environment
- **Git & GitHub**: Version control
- **MySQL Workbench**: Database management

## **📁 Project Structure**

```
ComplaintManagementSystem/
├── src/
│   └── com/
│       └── complaint/
│           ├── model/
│           │   ├── Complaint.java
│           │   └── Status.java
│           ├── dao/
│           │   ├── ComplaintDAO.java
│           │   └── DBConnection.java
│           └── servlet/
│               └── ComplaintServlet.java
├── WebContent/
│   ├── WEB-INF/
│   │   └── web.xml
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   └── script.js
│   ├── complaint.jsp
│   ├── viewStatus.jsp
│   ├── confirmation.jsp
│   └── dashboard.jsp
├── lib/
│   └── mysql-connector-java.jar
└── README.md
```

## **🎨 UI Features**

### **Visual Elements:**
- **Gradient Background**: Modern color scheme
- **Card-based Layout**: Clean, organized content presentation
- **Status Indicators**: Color-coded status badges
- **Progress Timeline**: Visual progress tracking
- **Priority Badges**: Distinct colors for different priorities
- **Responsive Design**: Works on all device sizes

### **Interactive Features:**
- **Form Validation**: Client-side validation
- **Character Counter**: For issue description
- **Auto Ticket Generation**: Unique IDs for tracking
- **Email Confirmation**: Simulated email sending
- **Print Functionality**: Print complaint details

## **🔄 Workflow**

### **User Journey:**
1. **Submit Complaint** → Fill complaint form
2. **Receive Ticket ID** → Get unique tracking number
3. **Track Status** → Check progress anytime
4. **Get Resolution** → Receive final resolution

### **Status Flow:**
```
Submitted → In Progress → Resolved → Closed
```

## **📱 Pages Overview**

### **1. complaint.jsp**
- Complaint submission form
- Category and priority selection
- Issue description with character counter

### **2. viewStatus.jsp**
- Track complaint by Ticket ID
- Visual progress timeline
- Detailed complaint information

### **3. confirmation.jsp**
- Success confirmation after submission
- Ticket ID display
- Next steps guidance

### **4. dashboard.jsp** (Admin)
- View all complaints
- Update status
- Filter and search functionality
