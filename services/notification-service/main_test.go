package main

import (
    "net/http"
    "net/http/httptest"
    "testing"
)

func TestHealthHandler(t *testing.T) {
    req, _ := http.NewRequest("GET", "/health", nil)
    rr := httptest.NewRecorder()
    http.HandlerFunc(healthHandler).ServeHTTP(rr, req)
    if rr.Code != http.StatusOK {
        t.Errorf("expected 200 got %v", rr.Code)
    }
}

func TestGetNotificationsHandler(t *testing.T) {
    req, _ := http.NewRequest("GET", "/notifications", nil)
    rr := httptest.NewRecorder()
    http.HandlerFunc(getNotificationsHandler).ServeHTTP(rr, req)
    if rr.Code != http.StatusOK {
        t.Errorf("expected 200 got %v", rr.Code)
    }
}
