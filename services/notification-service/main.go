package main

import (
    "encoding/json"
    "fmt"
    "net/http"
)

type Notification struct {
    ID      int    `json:"id"`
    Message string `json:"message"`
    Status  string `json:"status"`
}

var notifications []Notification

func healthHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]string{
        "status":  "healthy",
        "service": "notification-service",
    })
}

func notifyHandler(w http.ResponseWriter, r *http.Request) {
    if r.Method != http.MethodPost {
        http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
        return
    }
    var n Notification
    json.NewDecoder(r.Body).Decode(&n)
    n.ID = len(notifications) + 1
    n.Status = "sent"
    notifications = append(notifications, n)
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusCreated)
    json.NewEncoder(w).Encode(n)
}

func getNotificationsHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]interface{}{
        "notifications": notifications,
    })
}

func main() {
    http.HandleFunc("/health", healthHandler)
    http.HandleFunc("/notify", notifyHandler)
    http.HandleFunc("/notifications", getNotificationsHandler)
    fmt.Println("notification-service running on port 8080")
    http.ListenAndServe(":8080", nil)
}
