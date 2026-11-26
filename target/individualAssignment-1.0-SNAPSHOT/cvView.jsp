<%-- 
    Document   : cvForm
    Created on : 20 Oct 2026, 5:24:59 pm
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.cvbuilder.model.CVBean"%>
<%@page import="com.mycompany.cvbuilder.model.CVBean.Entry"%>

<%!
    private String esc(String s) {

        if (s == null) {
            return "";
        }

        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;")
                .replace("\n", "<br>");
    }

    private boolean has(String s) {
        return s != null && !s.trim().isEmpty();
    }
%>

<%
    CVBean cv = (CVBean) request.getAttribute("cv");

    if (cv == null) {
        response.sendRedirect(request.getContextPath() + "/cvForm.jsp");
        return;
    }

    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <title>CV Preview</title>

    <link rel="stylesheet"
      type="text/css"
      href="<%=request.getContextPath()%>/css/style.css?v=2">
</head>

<body class="preview-body">
<!-- TOP TOOLBAR -->

<div class="preview-toolbar no-print">

    <a class="button button-light"
    href="<%=request.getContextPath()%>/CVServlet?action=edit">

        Edit Details

    </a>
    <div class="toolbar-note">

        <span class="status-dot"></span>

        CV Preview

    </div>


    <button class="button button-primary"
            onclick="window.print()">

        Print / Save as PDF

    </button>

</div>


<!-- CV PREVIEW -->

<main class="preview-area">

    <article class="cv-sheet">


        <!-- HEADER -->

        <header class="cv-header">

            <div class="cv-name-block">

                <p class="cv-overline">
                    CURRICULUM VITAE
                </p>

                <h1>
                    <%=esc(cv.getFullName())%>
                </h1>


                <% if (has(cv.getJobTitle())) { %>

                    <p class="cv-role">
                        <%=esc(cv.getJobTitle())%>
                    </p>

                <% } %>

            </div>


            <div class="cv-contact">


                <% if (has(cv.getEmail())) { %>

                    <div>

                        <span>EMAIL</span>

                        <%=esc(cv.getEmail())%>

                    </div>

                <% } %>


                <% if (has(cv.getPhone())) { %>

                    <div>

                        <span>PHONE</span>

                        <%=esc(cv.getPhone())%>

                    </div>

                <% } %>


                <% if (has(cv.getAddress())) { %>

                    <div>

                        <span>LOCATION</span>

                        <%=esc(cv.getAddress())%>

                    </div>

                <% } %>


                <% if (has(cv.getLinkedin())) { %>

                    <div>

                        <span>LINKEDIN</span>

                        <%=esc(cv.getLinkedin())%>

                    </div>

                <% } %>


                <% if (has(cv.getWebsite())) { %>

                    <div>

                        <span>PORTFOLIO</span>

                        <%=esc(cv.getWebsite())%>

                    </div>

                <% } %>


            </div>

        </header>


        <!-- PROFESSIONAL SUMMARY -->

        <% if (has(cv.getSummary())) { %>

        <section class="cv-section">

            <h2>Professional Profile</h2>

            <p class="cv-paragraph">
                <%=esc(cv.getSummary())%>
            </p>

        </section>

        <% } %>


        <!-- EDUCATION -->

        <% if (!cv.getEducation().isEmpty()) { %>

        <section class="cv-section">

            <h2>Education</h2>


            <% for (Entry e : cv.getEducation()) { %>

            <div class="cv-entry">

                <div class="cv-entry-main">


                    <% if (has(e.getTitle())) { %>

                    <h3>
                        <%=esc(e.getTitle())%>
                    </h3>

                    <% } %>


                    <% if (has(e.getSubtitle())) { %>

                    <p class="cv-subtitle">
                        <%=esc(e.getSubtitle())%>
                    </p>

                    <% } %>


                    <% if (has(e.getDescription())) { %>

                    <p class="cv-description">
                        <%=esc(e.getDescription())%>
                    </p>

                    <% } %>


                </div>


                <% if (has(e.getDate())) { %>

                <div class="cv-date">
                    <%=esc(e.getDate())%>
                </div>

                <% } %>


            </div>

            <% } %>

        </section>

        <% } %>


        <!-- EXPERIENCE -->

        <% if (!cv.getExperience().isEmpty()) { %>

        <section class="cv-section">

            <h2>Work Experience</h2>


            <% for (Entry e : cv.getExperience()) { %>

            <div class="cv-entry">

                <div class="cv-entry-main">


                    <% if (has(e.getTitle())) { %>

                    <h3>
                        <%=esc(e.getTitle())%>
                    </h3>

                    <% } %>


                    <% if (has(e.getSubtitle())) { %>

                    <p class="cv-subtitle">
                        <%=esc(e.getSubtitle())%>
                    </p>

                    <% } %>


                    <% if (has(e.getDescription())) { %>

                    <p class="cv-description">
                        <%=esc(e.getDescription())%>
                    </p>

                    <% } %>


                </div>


                <% if (has(e.getDate())) { %>

                <div class="cv-date">
                    <%=esc(e.getDate())%>
                </div>

                <% } %>


            </div>

            <% } %>

        </section>

        <% } %>


        <!-- PROJECTS -->

        <% if (!cv.getProjects().isEmpty()) { %>

        <section class="cv-section">

            <h2>Projects</h2>


            <% for (Entry e : cv.getProjects()) { %>

            <div class="cv-entry">

                <div class="cv-entry-main">


                    <% if (has(e.getTitle())) { %>

                    <h3>
                        <%=esc(e.getTitle())%>
                    </h3>

                    <% } %>


                    <% if (has(e.getSubtitle())) { %>

                    <p class="cv-subtitle">
                        <%=esc(e.getSubtitle())%>
                    </p>

                    <% } %>


                    <% if (has(e.getDescription())) { %>

                    <p class="cv-description">
                        <%=esc(e.getDescription())%>
                    </p>

                    <% } %>


                </div>


                <% if (has(e.getDate())) { %>

                <div class="cv-date">
                    <%=esc(e.getDate())%>
                </div>

                <% } %>


            </div>

            <% } %>

        </section>

        <% } %>


        <!-- CERTIFICATIONS -->

        <% if (!cv.getCertifications().isEmpty()) { %>

        <section class="cv-section">

            <h2>Certifications & Achievements</h2>


            <% for (Entry e : cv.getCertifications()) { %>

            <div class="cv-entry">

                <div class="cv-entry-main">


                    <% if (has(e.getTitle())) { %>

                    <h3>
                        <%=esc(e.getTitle())%>
                    </h3>

                    <% } %>


                    <% if (has(e.getSubtitle())) { %>

                    <p class="cv-subtitle">
                        <%=esc(e.getSubtitle())%>
                    </p>

                    <% } %>


                    <% if (has(e.getDescription())) { %>

                    <p class="cv-description">
                        <%=esc(e.getDescription())%>
                    </p>

                    <% } %>


                </div>


                <% if (has(e.getDate())) { %>

                <div class="cv-date">
                    <%=esc(e.getDate())%>
                </div>

                <% } %>


            </div>

            <% } %>

        </section>

        <% } %>


        <!-- SKILLS -->

        <% if (has(cv.getSkills())) { %>

        <section class="cv-section">

            <h2>Core Skills</h2>

            <div class="skill-list">

                <% for (String skill : cv.getSkills().split(",")) {

                    if (has(skill)) {

                %>

                <span class="skill-chip">
                    <%=esc(skill.trim())%>
                </span>

                <% } } %>

            </div>

        </section>

        <% } %>


        <!-- LANGUAGES -->

        <% if (has(cv.getLanguages())) { %>

        <section class="cv-section">

            <h2>Languages</h2>

            <p class="cv-paragraph">
                <%=esc(cv.getLanguages())%>
            </p>

        </section>

        <% } %>


        <!-- REFERENCES -->

        <% if (has(cv.getReferences())) { %>

        <section class="cv-section">

            <h2>References</h2>

            <p class="cv-paragraph">
                <%=esc(cv.getReferences())%>
            </p>

        </section>

        <% } %>


        <!-- FOOTER -->

        <footer class="cv-footer">

            <span>
                <%=esc(cv.getFullName())%>
            </span>

            <span>
                CURRICULUM VITAE
            </span>

        </footer>


    </article>

</main>


</body>
</html>