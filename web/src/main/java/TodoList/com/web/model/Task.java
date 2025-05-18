package TodoList.com.web.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.Date;

public class Task {
    private int taskID; // Thêm trường TaskID
    private int userID; // Thêm trường UserID
    private String name;
    private String description;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate Date;
    private int categoryID; // Thêm trường CategoryID
    private int priorityID; // Thêm trường PriorityID

    private boolean Status;

    // Getters and Setters
    public int getTaskID() {
        return taskID;
    }

    public void setTaskID(int taskID) {
        this.taskID = taskID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getDate() {
        return Date;
    }

    public void setDate(java.sql.Date date2) {
        this.Date = date2.toLocalDate();
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getPriorityID() {
        return priorityID;
    }

    public void setPriorityID(int priorityID) {
        this.priorityID = priorityID;
    }

    @Override
    public String toString() {
        return "Task [taskID=" + taskID + ", userID=" + userID + ", name=" + name + ", description=" + description
                + ", Date=" + Date + ", categoryID=" + categoryID + ", priorityID=" + priorityID + "]";
    }

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean status) {
        Status = status;
    }

}
