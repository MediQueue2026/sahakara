# Domestic Household & Worker Operations Platform

A localized, accessible, and offline-first household operations platform built to simplify domestic workflow management, bridge language/literacy gaps, and ensure transparent compensation tracking between households and domestic staff.

---

## 🌟 Key Features

### 1. Inclusive & Accessible Interface
- **Multilingual Support:** Per-user language switching across Sinhala, Tamil, and English.
- **Audio-Guided Tasks:** One-tap audio playback for every task to support varying literacy levels.
- **Visual Task Library:** Photo-driven task references showing target standard ("what done looks like").
- **Voice Communication:** Two-way voice notes replacing complex text messaging.

### 2. Task & Schedule Management
- **Smart Scheduling:** Task templates with recurring intervals (daily, weekly, monthly) and auto-generated daily queues.
- **Daily Load Meter:** Smart warnings when daily task assignments exceed realistic capacity.
- **Reason Codes & Proof:** Status updates for obstacles (`No Supplies`, `Power Cut`, `Water Cut`, `Sick`) and optional photo completion proof.
- **Multi-Employer Support:** Dedicated view allowing part-time domestic workers to manage schedules across multiple households transparently.

### 3. Attendance & Leave
- Quick check-in/check-out for full days, half days, and overtime logging.
- Integrated Sri Lankan public and Poya holiday calendar.
- Request and approval flow for leave management.

### 4. Transparent Payroll Ledger
- Support for monthly, daily wage, hourly, and per-visit payment structures.
- Automatic tracking of cash advances and scheduled monthly deductions.
- Multi-language digital payslip generation shareable via WhatsApp/Image format.
- Shared discrepancy flagging to ensure mutual trust without silent adjustments.

### 5. Positive Reinforcement
- One-directional star rating and appreciation system for milestone tracking.
- Suggested performance-based bonuses (owner-confirmed).

---

## 🛠️ Architecture & Tech Stack

- **App:** Flutter — one codebase for the owner/maid mobile app (Android/iOS)
  and the staff admin panel (Flutter Web), optimized for low-end devices.
- **Backend:** [Supabase](https://supabase.com) — Postgres database, phone
  OTP auth, storage, realtime, row-level security per household.
- **Offline Sync:** local-first caching layer for low-connectivity
  environments (planned — see `app/README.md`).
- **Notifications:** Firebase Cloud Messaging, triggered by Supabase Edge
  Functions (planned).
- **Audio & Media:** localized audio clips / image assets in Supabase
  Storage, linked from the task library.

## 🚀 Getting started

1. [`supabase/README.md`](supabase/README.md) — create a Supabase project
   and run the database schema.
2. [`app/README.md`](app/README.md) — configure credentials and run the
   Flutter app (mobile) or the admin panel (`flutter run -d chrome`).

```
sahakara/
  app/         Flutter app — mobile (owner/maid) + web (admin panel)
  supabase/    Database schema, RLS policies, seed data
```
