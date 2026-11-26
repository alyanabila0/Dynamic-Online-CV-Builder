/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.cvbuilder.model;

/**
 *
 * @author admin
 */

// Import untuk Serializable dan senarai data
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * CVBean digunakan untuk menyimpan semua maklumat CV pengguna.
 * Class ini bertindak sebagai model dalam konsep MVC.
 */
public class CVBean implements Serializable {

    // Personal Information
    private String fullName = "";
    private String jobTitle = "";
    private String email = "";
    private String phone = "";
    private String address = "";
    private String linkedin = "";
    private String website = "";

    // Additional Information
    private String summary = "";
    private String skills = "";
    private String languages = "";
    private String references = "";

    // Senarai maklumat yang boleh mempunyai banyak entry
    private List<Entry> education = new ArrayList<>();
    private List<Entry> experience = new ArrayList<>();
    private List<Entry> projects = new ArrayList<>();
    private List<Entry> certifications = new ArrayList<>();

    // Constructor
    public CVBean() {
    }

    // Getter and Setter: Personal Information

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = safe(fullName);
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = safe(jobTitle);
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = safe(email);
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = safe(phone);
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = safe(address);
    }

    public String getLinkedin() {
        return linkedin;
    }

    public void setLinkedin(String linkedin) {
        this.linkedin = safe(linkedin);
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = safe(website);
    }

    // Getter and Setter: Additional Information

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = safe(summary);
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = safe(skills);
    }

    public String getLanguages() {
        return languages;
    }

    public void setLanguages(String languages) {
        this.languages = safe(languages);
    }

    public String getReferences() {
        return references;
    }

    public void setReferences(String references) {
        this.references = safe(references);
    }

    // Getter and Setter: Education

    public List<Entry> getEducation() {
        return education;
    }

    public void setEducation(List<Entry> education) {
        this.education = education == null
                ? new ArrayList<>() : education;
    }

    // Getter and Setter: Experience

    public List<Entry> getExperience() {
        return experience;
    }

    public void setExperience(List<Entry> experience) {
        this.experience = experience == null
                ? new ArrayList<>() : experience;
    }

    // Getter and Setter: Projects

    public List<Entry> getProjects() {
        return projects;
    }

    public void setProjects(List<Entry> projects) {
        this.projects = projects == null
                ? new ArrayList<>() : projects;
    }

    // Getter and Setter: Certifications

    public List<Entry> getCertifications() {
        return certifications;
    }

    public void setCertifications(List<Entry> certifications) {
        this.certifications = certifications == null
                ? new ArrayList<>() : certifications;
    }

    // Mengelakkan nilai null daripada disimpan
    private String safe(String value) {
        return value == null ? "" : value.trim();
    }

    /**
     * Inner class Entry digunakan untuk menyimpan satu rekod
     * Education, Experience, Project atau Certification.
     */
    public static class Entry implements Serializable {

        private String title = "";
        private String subtitle = "";
        private String date = "";
        private String description = "";

        // Default constructor
        public Entry() {
        }

        // Constructor untuk menerima semua maklumat entry
        public Entry(String title, String subtitle,
                     String date, String description) {

            this.title = title == null ? "" : title;
            this.subtitle = subtitle == null ? "" : subtitle;
            this.date = date == null ? "" : date;
            this.description = description == null
                    ? "" : description;
        }

        // Getter and Setter: Title

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title == null ? "" : title;
        }

        // Getter and Setter: Subtitle

        public String getSubtitle() {
            return subtitle;
        }

        public void setSubtitle(String subtitle) {
            this.subtitle = subtitle == null ? "" : subtitle;
        }

        // Getter and Setter: Date

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date == null ? "" : date;
        }

        // Getter and Setter: Description

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description == null
                    ? "" : description;
        }
    }
}
