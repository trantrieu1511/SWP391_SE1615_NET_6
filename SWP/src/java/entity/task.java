/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Khanh
 */
public class task {
    String name;
    int priority;
    String deadline;
    int status;
    String assigned;

    public task() {
    }

    public task(String name, int priority, String deadline, int status, String assigned) {
        this.name = name;
        this.priority = priority;
        this.deadline = deadline;
        this.status = status;
        this.assigned = assigned;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAssigned() {
        return assigned;
    }

    public void setAssigned(String assigned) {
        this.assigned = assigned;
    }

    @Override
    public String toString() {
        return "task{" + "name=" + name + ", priority=" + priority + ", deadline=" + deadline + ", status=" + status + ", assigned=" + assigned + '}';
    }

}
