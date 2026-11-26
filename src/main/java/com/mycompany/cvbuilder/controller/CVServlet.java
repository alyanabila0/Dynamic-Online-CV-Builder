/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.cvbuilder.controller;

/**
 *
 * @author admin
 */

// Import CVBean dan Entry
import com.mycompany.cvbuilder.model.CVBean;
import com.mycompany.cvbuilder.model.CVBean.Entry;

// Import Servlet
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Import Java utilities
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * CVServlet bertindak sebagai Controller dalam MVC.
 * Servlet menerima data daripada borang dan menguruskan paparan CV.
 */
@WebServlet(name = "CVServlet", urlPatterns = {"/CVServlet"})
public class CVServlet extends HttpServlet {

    /**
     * doGet menguruskan permintaan untuk Sample CV dan Edit CV.
     * @param request
     * @param response
     * @throws jakarta.servlet.ServletException
     * @throws java.io.IOException
     */
    
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Dapatkan session pengguna
        HttpSession session = request.getSession();

        // Tindakan untuk memaparkan Sample CV
        if ("sample".equalsIgnoreCase(action)) {

            CVBean sampleCV = createSampleCV();

            request.setAttribute("cv", sampleCV);

            request.getRequestDispatcher("/cvView.jsp")
                    .forward(request, response);

        }

        // Tindakan untuk mengedit CV yang telah dijana
        else if ("edit".equalsIgnoreCase(action)) {

            CVBean cv = (CVBean) session.getAttribute("cvData");

            // Jika data CV wujud dalam session
            if (cv != null) {

                request.setAttribute("cv", cv);

                request.getRequestDispatcher("/cvForm.jsp")
                        .forward(request, response);

            } else {

                // Jika tiada data, buka borang kosong
                response.sendRedirect(
                        request.getContextPath() + "/cvForm.jsp"
                );
            }
        }

        // Tindakan lalai: buka borang CV
        else {

            request.getRequestDispatcher("/cvForm.jsp")
                    .forward(request, response);
        }
    }

    /**
     * doPost menerima semua maklumat yang dihantar daripada cvForm.jsp.
     * @param request
     * @param response
     * @throws jakarta.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {

            // Cipta objek CVBean baharu
            CVBean cv = new CVBean();

            // --------------------------------
            // 1. PERSONAL INFORMATION
            // --------------------------------

            cv.setFullName(getValue(request, "fullName"));
            cv.setJobTitle(getValue(request, "jobTitle"));
            cv.setEmail(getValue(request, "email"));
            cv.setPhone(getValue(request, "phone"));
            cv.setAddress(getValue(request, "address"));
            cv.setLinkedin(getValue(request, "linkedin"));
            cv.setWebsite(getValue(request, "website"));

            // --------------------------------
            // 2. ADDITIONAL INFORMATION
            // --------------------------------

            cv.setSummary(getValue(request, "summary"));
            cv.setSkills(getValue(request, "skills"));
            cv.setLanguages(getValue(request, "languages"));
            cv.setReferences(getValue(request, "references"));

            // --------------------------------
            // 3. EDUCATION
            // --------------------------------

            cv.setEducation(readEntries(
                    request,
                    "eduTitle",
                    "eduSubtitle",
                    "eduDate",
                    "eduDescription"
            ));

            // --------------------------------
            // 4. WORK EXPERIENCE
            // --------------------------------

            cv.setExperience(readEntries(
                    request,
                    "expTitle",
                    "expSubtitle",
                    "expDate",
                    "expDescription"
            ));

            // --------------------------------
            // 5. PROJECTS
            // --------------------------------

            cv.setProjects(readEntries(
                    request,
                    "projectTitle",
                    "projectSubtitle",
                    "projectDate",
                    "projectDescription"
            ));

            // --------------------------------
            // 6. CERTIFICATIONS
            // --------------------------------

            cv.setCertifications(readEntries(
                    request,
                    "certTitle",
                    "certSubtitle",
                    "certDate",
                    "certDescription"
            ));

            // --------------------------------
            // 7. VALIDATE FULL NAME
            // --------------------------------

            if (cv.getFullName().trim().isEmpty()) {

                request.setAttribute(
                        "errorMessage",
                        "Please enter your full name."
                );

                request.setAttribute("cv", cv);

                request.getRequestDispatcher("/cvError.jsp")
                        .forward(request, response);

                return;
            }

            // --------------------------------
            // 8. SAVE CV DATA IN SESSION
            // --------------------------------

            HttpSession session = request.getSession();

            session.setAttribute("cvData", cv);

            // --------------------------------
            // 9. FORWARD TO CV PREVIEW
            // --------------------------------

            request.setAttribute("cv", cv);

            request.getRequestDispatcher("/cvView.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            // Paparkan ralat pada console NetBeans
            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Unable to generate CV. Please check your information."
            );

            request.getRequestDispatcher("/cvError.jsp")
                    .forward(request, response);
        }
    }

    /**
     * Mendapatkan satu parameter daripada borang.
     * Jika parameter null, pulangkan string kosong.
     */
    private String getValue(HttpServletRequest request, String name) {

        String value = request.getParameter(name);

        return value == null ? "" : value.trim();
    }

    /**
     * Membaca semua entry daripada section berulang.
     * Contohnya Education boleh mempunyai lebih daripada satu entry.
     */
    private List<Entry> readEntries(
            HttpServletRequest request,
            String titleName,
            String subtitleName,
            String dateName,
            String descriptionName) {

        String[] titles = request.getParameterValues(titleName);
        String[] subtitles = request.getParameterValues(subtitleName);
        String[] dates = request.getParameterValues(dateName);
        String[] descriptions =
                request.getParameterValues(descriptionName);

        List<Entry> result = new ArrayList<>();

        // Tiada entry dihantar
        if (titles == null) {
            return result;
        }

        // Baca setiap entry berdasarkan indeks
        for (int i = 0; i < titles.length; i++) {

            String title = getArrayValue(titles, i);
            String subtitle = getArrayValue(subtitles, i);
            String date = getArrayValue(dates, i);
            String description = getArrayValue(descriptions, i);

            // Simpan entry jika sekurang-kurangnya satu medan diisi
            if (!title.isEmpty()
                    || !subtitle.isEmpty()
                    || !date.isEmpty()
                    || !description.isEmpty()) {

                result.add(new Entry(
                        title,
                        subtitle,
                        date,
                        description
                ));
            }
        }

        return result;
    }

    /**
     * Mendapatkan nilai daripada array parameter dengan selamat.
     */
    private String getArrayValue(String[] values, int index) {

        if (values != null
                && index < values.length
                && values[index] != null) {

            return values[index].trim();
        }

        return "";
    }

    /**
     * Membina data contoh untuk fungsi Sample CV.
     */
    private CVBean createSampleCV() {

        CVBean cv = new CVBean();

        // Personal Information
        cv.setFullName("NUR ALYA NABILA BINTI KAIRUL AZHA");
        cv.setJobTitle("Computer Science Student");
        cv.setEmail("alyanabila@email.com");
        cv.setPhone("+60123456789");
        cv.setAddress("Dungun, Terengganu, Malaysia");

        cv.setLinkedin("https://www.linkedin.com/in/alya-2086b5352");
        cv.setWebsite("http://portfolio");

        // Professional Summary
        cv.setSummary(
                "A motivated Diploma in Computer Science student "
                + "with an interest in information systems, data analysis "
                + "and problem solving. Able to work independently and "
                + "collaboratively, with a willingness to learn new "
                + "technologies and contribute to organisational goals."
        );

        // Skills
        cv.setSkills(
                "Java, JSP, Servlet, HTML, CSS, JavaScript, SQL, "
                + "MySQL, Microsoft Office, Canva, Problem Solving"
        );

        // Languages
        cv.setLanguages(
                "Malay (Native), English (Intermediate), Arab (Intermediate)"
        );

        // References
        cv.setReferences("Available upon request");

        // Education
        cv.getEducation().add(new Entry(
                "Diploma in Computer Science",
                "Universiti Teknologi MARA (UiTM)",
                "2023 – 2025",
                "Relevant coursework: Object-Oriented Programming, "
                + "Database, Web-Based Applications and System Analysis."
        ));

        // Work Experience
        cv.getExperience().add(new Entry(
                "Industrial Trainee",
                "Administration & Management Department",
                "Sep 2025 – Feb 2026",
                "Assisted with internal system documentation, data "
                + "management and administrative tasks. Supported the "
                + "preparation and maintenance of digital records."
        ));

        // Projects
        cv.getProjects().add(new Entry(
                "Dynamic CV Builder",
                "Academic Project | JSP, Servlet, JavaBean",
                "2026",
                "Developed a web-based CV builder that allows users "
                + "to enter personal details, add multiple sections "
                + "and generate a print-ready CV."
        ));

        cv.getProjects().add(new Entry(
                "Cafe Ordering System",
                "Academic Project | PHP, MySQL",
                "2025",
                "Developed an ordering system with menu management, "
                + "customer orders and an administrative interface."
        ));

        // Certifications
        cv.getCertifications().add(new Entry(
                "Introduction to Data Analytics",
                "Online Learning",
                "2025",
                "Completed introductory learning in data handling "
                + "and analytical thinking."
        ));

        return cv;
    }
}
