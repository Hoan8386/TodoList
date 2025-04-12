package TodoList.com.web.model;

import java.sql.Date;

public class TaskCategoryPriorityDTO {
    private int taskID;
    private int userID;
    private String name;
    private String description;
    private Date date;

    // Category
    private int categoryID;
    private String categoryName;
    private String categoryColor;

    // Priority
    private int priorityID;
    private String priorityName;

    private boolean Status;

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryColor() {
        return categoryColor;
    }

    public void setCategoryColor(String categoryColor) {
        this.categoryColor = categoryColor;
    }

    public int getPriorityID() {
        return priorityID;
    }

    public void setPriorityID(int priorityID) {
        this.priorityID = priorityID;
    }

    public String getPriorityName() {
        return priorityName;
    }

    public void setPriorityName(String priorityName) {
        this.priorityName = priorityName;
    }

    @Override
    public String toString() {
        return "TaskCategoryPriorityDTO [taskID=" + taskID + ", userID=" + userID + ", name=" + name + ", description="
                + description + ", date=" + date + ", categoryID=" + categoryID + ", categoryName=" + categoryName
                + ", categoryColor=" + categoryColor + ", priorityID=" + priorityID + ", priorityName=" + priorityName
                + ", Status=" + Status + "]";
    }

}
