<%-- 
    Document   : cvForm
    Created on : 20 Oct 2026, 5:24:59 pm
    Author     : admin
--%>

<%--
    Document   : cvForm
    Purpose    : Display CV form and restore previously entered information
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.cvbuilder.model.CVBean"%>
<%@page import="com.mycompany.cvbuilder.model.CVBean.Entry"%>
<%@page import="java.util.List"%>

<%!
    // Escape HTML characters to prevent invalid HTML output.
    public String esc(String value) {
        if (value == null) return "";

        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }

    // Generate one or more entry cards for a repeatable section.
    public String renderEntries(
            List<Entry> entries,
            String prefix,
            String sectionName,
            String fieldOne,
            String fieldTwo,
            String fieldThree,
            String fieldFour) {

        StringBuilder html = new StringBuilder();

        // If no previous entry exists, show one empty card.
        if (entries == null || entries.isEmpty()) {
            entries = new java.util.ArrayList<>();
            entries.add(new Entry("", "", "", ""));
        }

        // Generate a card for each saved entry.
        for (int i = 0; i < entries.size(); i++) {

            Entry e = entries.get(i);

            html.append("<div class='entry-card'>");

            html.append("<div class='entry-top'>");
            html.append("<strong>")
                .append(esc(sectionName))
                .append(" ")
                .append(i + 1)
                .append("</strong>");

            html.append("<button type='button' class='remove-entry' ")
                .append("onclick='removeEntry(this)'>Remove</button>");

            html.append("</div>");

            html.append("<div class='form-grid'>");

            // First field
            html.append("<label class='field'>")
                .append(esc(fieldOne))
                .append("<input type='text' name='")
                .append(prefix).append("Title' value='")
                .append(esc(e.getTitle()))
                .append("'></label>");

            // Second field
            html.append("<label class='field'>")
                .append(esc(fieldTwo))
                .append("<input type='text' name='")
                .append(prefix).append("Subtitle' value='")
                .append(esc(e.getSubtitle()))
                .append("'></label>");

            // Third field
            html.append("<label class='field full'>")
                .append(esc(fieldThree))
                .append("<input type='text' name='")
                .append(prefix).append("Date' value='")
                .append(esc(e.getDate()))
                .append("'></label>");

            // Fourth field
            html.append("<label class='field full'>")
                .append(esc(fieldFour))
                .append("<textarea name='")
                .append(prefix).append("Description' rows='3'>")
                .append(esc(e.getDescription()))
                .append("</textarea></label>");

            html.append("</div>");
            html.append("</div>");
        }

        return html.toString();
    }
%>

<%
    // Get application context path.
    String ctx = request.getContextPath();

    // Retrieve CV object sent by CVServlet.
    CVBean cv = (CVBean) request.getAttribute("cv");

    // If request attribute is unavailable, retrieve CV from session.
    if (cv == null) {
        cv = (CVBean) session.getAttribute("cvData");
    }

    // Create an empty CV for a new user.
    if (cv == null) {
        cv = new CVBean();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Dynamic CV Builder</title>

    <!-- External stylesheet -->
    <link rel="stylesheet"
          type="text/css"
          href="<%=ctx%>/css/style.css?v=2">

</head>

<body class="app-body">

<!-- Navigation bar -->
<header class="topbar no-print">

    <nav>

        <a class="nav-link active"
           href="<%=ctx%>/CVServlet">

            Create CV

        </a>

        <a class="nav-link"
           href="<%=ctx%>/CVServlet?action=sample"
           target="_blank">

            Sample CV

        </a>

    </nav>

</header>

<main class="builder-wrap">

    <!-- Main CV form -->
    <form action="<%=ctx%>/CVServlet"
          method="post"
          id="cvForm">

        <div class="form-paper">

            <!-- FORM HEADER -->
            <div class="paper-heading">

                <div>

                    <span class="paper-kicker">
                        CAREER CANVAS / CV BUILDER
                    </span>

                    <h2>Curriculum Vitae</h2>

                    <p>
                        Build a clear and professional profile.
                    </p>

                </div>

                <div class="paper-number">
                    01 <span>/ FORM</span>
                </div>

            </div>

            <!-- 01 PERSONAL INFORMATION -->
            <section class="form-section">

                <div class="section-heading">

                    <span class="section-number">01</span>

                    <div>
                        <h3>Personal Information</h3>
                        <p>Your basic contact details</p>
                    </div>

                </div>

                <div class="form-grid">

                    <label class="field full">

                        Full Name <b>*</b>

                        <input type="text"
                               name="fullName"
                               required
                               value="<%=esc(cv.getFullName())%>"
                               placeholder="e.g. Nur Alya Nabila Binti Kairul Azha">

                    </label>

                    <label class="field full">

                        Professional Title

                        <input type="text"
                               name="jobTitle"
                               value="<%=esc(cv.getJobTitle())%>"
                               placeholder="e.g. Computer Science Student">

                    </label>

                    <label class="field">

                        Email Address

                        <input type="email"
                               name="email"
                               value="<%=esc(cv.getEmail())%>"
                               placeholder="name@email.com">

                    </label>

                    <label class="field">

                        Phone Number

                        <input type="text"
                               name="phone"
                               value="<%=esc(cv.getPhone())%>"
                               placeholder="+60123456789">

                    </label>

                    <label class="field full">

                        Address

                        <input type="text"
                               name="address"
                               value="<%=esc(cv.getAddress())%>"
                               placeholder="City, State, Country">

                    </label>

                    <label class="field">

                        LinkedIn

                        <input type="text"
                               name="linkedin"
                               value="<%=esc(cv.getLinkedin())%>"
                               placeholder="linkedin.com/in/username">

                    </label>

                    <label class="field">

                        Website / Portfolio

                        <input type="text"
                               name="website"
                               value="<%=esc(cv.getWebsite())%>"
                               placeholder="yourportfolio.com">

                    </label>

                </div>

            </section>

            <!-- 02 PROFESSIONAL SUMMARY -->
            <section class="form-section">

                <div class="section-heading">

                    <span class="section-number">02</span>

                    <div>
                        <h3>Professional Summary</h3>
                        <p>A short introduction about yourself</p>
                    </div>

                </div>

                <label class="field">

                    Profile Summary

                    <textarea name="summary"
                              rows="5"
                              placeholder="Write 3–5 sentences about your background, strengths and career goals."><%=esc(cv.getSummary())%></textarea>

                </label>

            </section>

            <!-- 03 EDUCATION -->
            <section class="form-section">

                <div class="section-heading">

                    <span class="section-number">03</span>

                    <div>
                        <h3>Education</h3>
                        <p>Academic background and qualifications</p>
                    </div>

                </div>

                <div id="educationList" class="entry-list">

                    <%=renderEntries(
                        cv.getEducation(),
                        "edu",
                        "Education",
                        "Qualification",
                        "Institution",
                        "Period",
                        "Details"
                    )%>

                </div>

                <button type="button"
                        class="add-entry"
                        onclick="addEntry('educationList')">

                    + Add Education

                </button>

            </section>

            <!-- 04 WORK EXPERIENCE -->
            <section class="form-section">

                <div class="section-heading">

                    <span class="section-number">04</span>

                    <div>
                        <h3>Work Experience</h3>
                        <p>Employment, internship or volunteering</p>
                    </div>

                </div>

                <div id="experienceList" class="entry-list">

                    <%=renderEntries(
                        cv.getExperience(),
                        "exp",
                        "Experience",
                        "Job Title",
                        "Company / Organisation",
                        "Period",
                        "Responsibilities and Achievements"
                    )%>

                </div>

                <button type="button"
                        class="add-entry"
                        onclick="addEntry('experienceList')">

                    + Add Experience

                </button>

            </section>

            <!-- 05 PROJECTS -->
            <section class="form-section">

                <div class="section-heading">

                    <span class="section-number">05</span>

                    <div>
                        <h3>Projects</h3>
                        <p>Academic, personal or professional projects</p>
                    </div>

                </div>

                <div id="projectsList" class="entry-list">

                    <%=renderEntries(
                        cv.getProjects(),
                        "project",
                        "Project",
                        "Project Name",
                        "Role / Technologies",
                        "Period",
                        "Description"
                    )%>

                </div>

                <button type="button"
                        class="add-entry"
                        onclick="addEntry('projectsList')">

                    + Add Project

                </button>

            </section>

            <!-- 06 CERTIFICATIONS -->
            <section class="form-section">

                <div class="section-heading">

                    <span class="section-number">06</span>

                    <div>
                        <h3>Certifications & Achievements</h3>
                        <p>Courses, certificates and awards</p>
                    </div>

                </div>

                <div id="certificationsList" class="entry-list">

                    <%=renderEntries(
                        cv.getCertifications(),
                        "cert",
                        "Certification",
                        "Certificate / Achievement",
                        "Issuer",
                        "Date",
                        "Details"
                    )%>

                </div>

                <button type="button"
                        class="add-entry"
                        onclick="addEntry('certificationsList')">

                    + Add Certification

                </button>

            </section>

            <!-- 07 ADDITIONAL INFORMATION -->
            <section class="form-section">

                <div class="section-heading">

                    <span class="section-number">07</span>

                    <div>
                        <h3>Additional Information</h3>
                        <p>Skills, languages and references</p>
                    </div>

                </div>

                <div class="form-grid">

                    <label class="field full">

                        Skills

                        <textarea name="skills"
                                  rows="3"
                                  placeholder="Java, HTML, CSS, SQL, Communication, Problem Solving"><%=esc(cv.getSkills())%></textarea>

                    </label>

                    <label class="field full">

                        Languages

                        <textarea name="languages"
                                  rows="2"
                                  placeholder="Malay (Native), English (Intermediate)"><%=esc(cv.getLanguages())%></textarea>

                    </label>

                    <label class="field full">

                        References

                        <textarea name="references"
                                  rows="2"
                                  placeholder="Available upon request"><%=esc(cv.getReferences())%></textarea>

                    </label>

                </div>

            </section>

            <!-- FORM FOOTER -->
            <div class="form-footer">

                <span>CAREER CANVAS • PROFESSIONAL CV BUILDER</span>

                <span>Complete your details and generate your CV</span>

            </div>

        </div>

        <!-- FORM ACTION BUTTONS -->
        <div class="form-actions no-print">

            <a class="button button-light"
               href="<%=ctx%>/CVServlet?action=sample"
               target="_blank">

                View Sample CV

            </a>

            <button class="button button-primary"
                    type="submit">

                Generate My CV

            </button>

        </div>

    </form>

</main>

<!-- JavaScript for adding and removing entries -->
<script>

// Add a new entry by cloning the first entry card.
function addEntry(listId) {

    const list = document.getElementById(listId);

    const first = list.querySelector('.entry-card');

    // Clone the existing entry card.
    const clone = first.cloneNode(true);

    // Clear all previous input values.
    clone.querySelectorAll('input, textarea').forEach(function(el) {
        el.value = '';
    });

    // Add the cloned card to the section.
    list.appendChild(clone);

    // Update entry numbering.
    updateEntryLabels(list);
}


// Remove an entry card.
function removeEntry(button) {

    const list = button.closest('.entry-list');

    const cards = list.querySelectorAll('.entry-card');

    if (cards.length > 1) {

        button.closest('.entry-card').remove();

    } else {

        // Keep at least one empty card.
        button.closest('.entry-card')
              .querySelectorAll('input, textarea')
              .forEach(function(el) {
                  el.value = '';
              });
    }

    updateEntryLabels(list);
}


// Update the entry title and numbering.
function updateEntryLabels(list) {

    let label = 'Entry';

    if (list.id === 'educationList') {
        label = 'Education';
    }

    else if (list.id === 'experienceList') {
        label = 'Experience';
    }

    else if (list.id === 'projectsList') {
        label = 'Project';
    }

    else if (list.id === 'certificationsList') {
        label = 'Certification';
    }

    list.querySelectorAll('.entry-card').forEach(function(card, index) {

        card.querySelector('.entry-top strong').textContent =
                label + ' ' + (index + 1);

    });
}

</script>

</body>
</html>

