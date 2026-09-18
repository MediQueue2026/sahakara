import React, { useState, useEffect, useMemo } from "react";
import {
  Home, ClipboardList, CalendarCheck, Wallet, Settings, Star, Volume2,
  Check, HelpCircle, Plus, X, ChevronLeft, ChevronRight, AlertTriangle,
  Banknote, Flag, Clock, User, Languages, ArrowRightLeft, Trash2
} from "lucide-react";
import { LANGS, T, REASONS, LIBRARY, todayKey, money } from "./constants";
import { getState, updateState } from "./services/api";
import { Card } from "./components/Card";
import { Field } from "./components/Field";

export default function App() {
  const [lang, setLang] = useState("en");
  const [role, setRole] = useState("owner");
  const [tab, setTab] = useState("today");
  const [state, setState] = useState(null);
  const [loaded, setLoaded] = useState(false);
  const [modal, setModal] = useState(null);

  const t = (k) => (T[k] ? T[k][lang] : k);
  const name = (libId) => LIBRARY.find((x) => x.id === libId)?.[lang] || libId;

  useEffect(() => {
    (async () => {
      try {
        const data = await getState();
        setState(data);
      } catch (e) {
        console.error("Failed to load state", e);
      }
      setLoaded(true);
    })();
  }, []);

  const update = async (fn) => {
    const newState = { ...state, ...fn(state) };
    setState(newState);
    try {
      await updateState(fn(state));
    } catch(e) {
      console.error("Failed to save state", e);
    }
  };

  if (!loaded || !state) return <div className="p-8 text-center text-stone-500">Loading...</div>;

  const speak = (text) => {
    try {
      const u = new SpeechSynthesisUtterance(text);
      u.lang = LANGS.find((l) => l.id === lang).speech;
      u.rate = 0.85;
      window.speechSynthesis.cancel();
      window.speechSynthesis.speak(u);
    } catch (e) {
      /* speech unavailable */
    }
  };

  const d = todayKey();
  const todays = state.tasks.filter((x) => x.date === d);
  const plannedMins = todays.reduce((s, x) => s + x.mins, 0);
  const capacity = state.config.hours * 60;
  const loadPct = Math.min(100, Math.round((plannedMins / capacity) * 100));

  const monthStars = state.tasks.filter((x) => x.star).length;
  const monthDone = state.tasks.filter((x) => x.status === "done").length;
  const daysWorked = Object.values(state.attendance).filter((v) => v === "present").length
    + 0.5 * Object.values(state.attendance).filter((v) => v === "half").length;

  const ledger = (() => {
    const base = state.config.salary;
    const bonus = monthStars * state.config.perStar;
    const adv = state.ledger.filter((x) => x.type === "advance").reduce((s, x) => s + x.amount, 0);
    const paid = state.ledger.filter((x) => x.type === "payment").reduce((s, x) => s + x.amount, 0);
    const leaveDays = Object.values(state.attendance).filter((v) => v === "leave").length;
    const leaveCut = leaveDays * Math.round(base / 30);
    const earned = base + bonus;
    return { base, bonus, adv, paid, leaveCut, earned, due: earned - leaveCut - adv - paid };
  })();

  const setTaskStatus = (uid, status, reason) =>
    update((s) => ({
      tasks: s.tasks.map((x) => (x.uid === uid ? { ...x, status, reason: reason || null } : x)),
    }));

  const toggleStar = (uid) =>
    update((s) => ({ tasks: s.tasks.map((x) => (x.uid === uid ? { ...x, star: !x.star } : x)) }));

  const addTask = (libId, priority) => {
    const lib = LIBRARY.find((x) => x.id === libId);
    update((s) => ({
      tasks: [
        ...s.tasks,
        { uid: "u" + Date.now(), lib: libId, date: d, priority, status: "open", star: false, mins: lib.mins },
      ],
    }));
  };

  const removeTask = (uid) => update((s) => ({ tasks: s.tasks.filter((x) => x.uid !== uid) }));

  const addLedger = (type, amount, note) =>
    update((s) => ({
      ledger: [{ id: "l" + Date.now(), date: d, type, amount: Number(amount), note }, ...s.ledger],
    }));

  const markAttendance = (v) => update((s) => ({ attendance: { ...s.attendance, [d]: v } }));

  const isHelper = role === "helper";

  const Shell = ({ children }) => (
    <div className={`min-h-screen ${isHelper ? "bg-white" : "bg-stone-100"} text-stone-900`}>
      <header className={`${isHelper ? "bg-emerald-800" : "bg-stone-900"} text-white`}>
        <div className="max-w-2xl mx-auto px-4 py-3 flex items-center justify-between gap-3">
          <div className="flex items-center gap-2 min-w-0">
            <Home size={20} className="shrink-0" />
            <span className="font-medium truncate">{t("appName")}</span>
          </div>
          <div className="flex items-center gap-1">
            {LANGS.map((l) => (
              <button
                key={l.id}
                onClick={() => setLang(l.id)}
                className={`px-2.5 py-1.5 rounded text-sm ${
                  lang === l.id ? "bg-white text-stone-900" : "bg-white/15 hover:bg-white/25"
                }`}
              >
                {l.short}
              </button>
            ))}
          </div>
        </div>
      </header>

      <div className="bg-amber-100 border-b border-amber-200">
        <div className="max-w-2xl mx-auto px-4 py-2 flex items-center justify-between gap-2">
          <span className="text-xs text-amber-900 flex items-center gap-1.5">
            <ArrowRightLeft size={14} /> {t("viewAs")}
          </span>
          <div className="flex gap-1">
            {[
              { id: "owner", label: t("owner") },
              { id: "helper", label: t("helper") },
            ].map((r) => (
              <button
                key={r.id}
                onClick={() => {
                  setRole(r.id);
                  setTab("today");
                }}
                className={`px-3 py-1 rounded text-sm ${
                  role === r.id ? "bg-amber-900 text-white" : "bg-white text-amber-900 border border-amber-300"
                }`}
              >
                {r.label}
              </button>
            ))}
          </div>
        </div>
      </div>

      <main className="max-w-2xl mx-auto px-4 pb-28 pt-4">{children}</main>

      <nav className="fixed bottom-0 inset-x-0 bg-white border-t border-stone-200">
        <div className="max-w-2xl mx-auto grid grid-cols-4">
          {(isHelper
            ? [
                { id: "today", icon: ClipboardList, label: t("today") },
                { id: "month", icon: CalendarCheck, label: t("myMonth") },
                { id: "pay", icon: Wallet, label: t("payments") },
                { id: "set", icon: Settings, label: t("settings") },
              ]
            : [
                { id: "today", icon: ClipboardList, label: t("today") },
                { id: "att", icon: CalendarCheck, label: t("attendance") },
                { id: "pay", icon: Wallet, label: t("payments") },
                { id: "set", icon: Settings, label: t("settings") },
              ]
          ).map((n) => {
            const Icon = n.icon;
            const on = tab === n.id;
            return (
              <button
                key={n.id}
                onClick={() => setTab(n.id)}
                className={`py-2.5 flex flex-col items-center gap-1 ${
                  on ? "text-emerald-800" : "text-stone-500"
                }`}
              >
                <Icon size={isHelper ? 24 : 20} />
                <span className={isHelper ? "text-xs" : "text-[11px]"}>{n.label}</span>
              </button>
            );
          })}
        </div>
      </nav>
    </div>
  );

  const OwnerToday = () => (
    <div className="space-y-4">
      <Card className="p-4">
        <div className="flex items-baseline justify-between mb-2">
          <span className="text-sm text-stone-600">{t("dayLoad")}</span>
          <span className="text-sm font-medium">
            {Math.floor(plannedMins / 60)}h {plannedMins % 60}m {t("of")} {state.config.hours}h
          </span>
        </div>
        <div className="h-2 bg-stone-200 rounded overflow-hidden">
          <div
            className={`h-full ${loadPct > 85 ? "bg-amber-500" : "bg-emerald-700"}`}
            style={{ width: loadPct + "%" }}
          />
        </div>
        {loadPct > 85 && (
          <p className="text-xs text-amber-800 mt-2 flex gap-1.5">
            <AlertTriangle size={14} className="shrink-0 mt-0.5" />
            {t("loadWarn")}
          </p>
        )}
      </Card>

      <div className="flex items-center justify-between">
        <h2 className="text-lg font-medium">{t("today")}</h2>
        <button
          onClick={() => setModal("addTask")}
          className="flex items-center gap-1.5 text-sm bg-stone-900 text-white px-3 py-1.5 rounded-lg"
        >
          <Plus size={16} /> {t("addTask")}
        </button>
      </div>

      {todays.length === 0 && (
        <Card className="p-6 text-center text-stone-500 text-sm">{t("noTasks")}</Card>
      )}

      <div className="space-y-2">
        {todays
          .slice()
          .sort((a, b) => b.priority - a.priority)
          .map((x) => (
            <Card key={x.uid} className="p-3">
              <div className="flex items-start gap-3">
                <div className="flex-1 min-w-0">
                  <p
                    className={`font-medium ${
                      x.status === "done" ? "line-through text-stone-400" : ""
                    }`}
                  >
                    {name(x.lib)}
                  </p>
                  <p className="text-xs text-stone-500 mt-0.5">
                    {x.mins} {t("mins")}
                    {x.status === "blocked" && x.reason && (
                      <span className="text-rose-700">
                        {" · "}
                        {REASONS.find((r) => r.id === x.reason)?.[lang]}
                      </span>
                    )}
                  </p>
                </div>
                <span
                  className={`text-[11px] px-2 py-0.5 rounded shrink-0 ${
                    x.priority === 1
                      ? "bg-rose-100 text-rose-800"
                      : x.priority === 0
                      ? "bg-stone-100 text-stone-700"
                      : "bg-stone-50 text-stone-500"
                  }`}
                >
                  {x.priority === 1 ? t("high") : x.priority === 0 ? t("normal") : t("low")}
                </span>
              </div>

              <div className="flex items-center gap-2 mt-3">
                {x.status === "done" && (
                  <button
                    onClick={() => toggleStar(x.uid)}
                    className={`flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-lg border ${
                      x.star
                        ? "bg-amber-50 border-amber-300 text-amber-800"
                        : "border-stone-300 text-stone-600"
                    }`}
                  >
                    <Star size={16} fill={x.star ? "currentColor" : "none"} />
                    {x.star ? t("starred") : t("giveStar")}
                  </button>
                )}
                <button
                  onClick={() => removeTask(x.uid)}
                  className="ml-auto text-stone-400 p-1.5"
                  aria-label="Remove"
                >
                  <Trash2 size={16} />
                </button>
              </div>
            </Card>
          ))}
      </div>
    </div>
  );

  const HelperToday = () => (
    <div className="space-y-4">
      <div className="grid grid-cols-2 gap-3">
        <div className="bg-emerald-50 rounded-xl p-4">
          <p className="text-sm text-emerald-900">{t("daysWorked")}</p>
          <p className="text-3xl font-medium text-emerald-900">{daysWorked}</p>
        </div>
        <div className="bg-amber-50 rounded-xl p-4">
          <p className="text-sm text-amber-900">{t("stars")}</p>
          <p className="text-3xl font-medium text-amber-900 flex items-center gap-1">
            <Star size={24} fill="currentColor" /> {monthStars}
          </p>
        </div>
      </div>

      {todays.length === 0 && (
        <Card className="p-8 text-center text-stone-500">{t("noTasksHelper")}</Card>
      )}

      <div className="space-y-3">
        {todays
          .slice()
          .sort((a, b) => b.priority - a.priority)
          .map((x) => {
            const isDone = x.status === "done";
            const isBlocked = x.status === "blocked";
            return (
              <div
                key={x.uid}
                className={`rounded-xl border-2 p-4 ${
                  isDone
                    ? "bg-emerald-50 border-emerald-200"
                    : isBlocked
                    ? "bg-stone-50 border-stone-200"
                    : x.priority === 1
                    ? "bg-white border-rose-300"
                    : "bg-white border-stone-200"
                }`}
              >
                <div className="flex items-start gap-3">
                  <p className={`flex-1 text-xl leading-snug ${isDone ? "line-through text-emerald-800" : ""}`}>
                    {name(x.lib)}
                  </p>
                  <button
                    onClick={() => speak(name(x.lib))}
                    aria-label={t("listen")}
                    className="shrink-0 w-14 h-14 rounded-xl bg-emerald-700 text-white flex items-center justify-center"
                  >
                    <Volume2 size={26} />
                  </button>
                </div>

                <p className="text-sm text-stone-500 mt-1">
                  {x.mins} {t("mins")}
                  {x.priority === 1 && <span className="text-rose-700"> · {t("high")}</span>}
                </p>

                {isBlocked && x.reason && (
                  <p className="mt-2 text-sm text-stone-600">
                    {REASONS.find((r) => r.id === x.reason)?.[lang]}
                  </p>
                )}

                {x.star && (
                  <p className="mt-2 text-amber-800 flex items-center gap-1.5 text-sm">
                    <Star size={18} fill="currentColor" /> {t("starred")}
                  </p>
                )}

                {!isDone && !isBlocked && (
                  <div className="flex gap-2 mt-4">
                    <button
                      onClick={() => setTaskStatus(x.uid, "done")}
                      className="flex-1 h-14 rounded-xl bg-emerald-700 text-white text-lg flex items-center justify-center gap-2"
                    >
                      <Check size={22} /> {t("done")}
                    </button>
                    <button
                      onClick={() => setModal({ kind: "reason", uid: x.uid })}
                      className="flex-1 h-14 rounded-xl border-2 border-stone-300 text-lg flex items-center justify-center gap-2"
                    >
                      <HelpCircle size={22} /> {t("needHelp")}
                    </button>
                  </div>
                )}
              </div>
            );
          })}
      </div>
    </div>
  );

  const Attendance = () => {
    const status = state.attendance[d];
    const opts = [
      { id: "present", label: t("present"), cls: "bg-emerald-700 text-white" },
      { id: "half", label: t("halfDay"), cls: "bg-amber-500 text-white" },
      { id: "leave", label: t("leave"), cls: "bg-stone-400 text-white" },
    ];
    const days = Object.entries(state.attendance).slice(-14).reverse();
    return (
      <div className="space-y-4">
        <Card className="p-4">
          <p className="text-sm text-stone-600 mb-3">{new Date().toDateString()}</p>
          <div className="grid grid-cols-3 gap-2">
            {opts.map((o) => (
              <button
                key={o.id}
                onClick={() => markAttendance(o.id)}
                className={`py-3 rounded-lg text-sm ${
                  status === o.id ? o.cls : "bg-stone-100 text-stone-700"
                }`}
              >
                {o.label}
              </button>
            ))}
          </div>
          {!status && <p className="text-xs text-stone-400 mt-3">{t("notMarked")}</p>}
        </Card>

        <div className="grid grid-cols-2 gap-3">
          <div className="bg-white rounded-xl p-4 border border-stone-200">
            <p className="text-sm text-stone-600">{t("daysWorked")}</p>
            <p className="text-2xl font-medium">{daysWorked}</p>
          </div>
          <div className="bg-white rounded-xl p-4 border border-stone-200">
            <p className="text-sm text-stone-600">{t("tasksDone")}</p>
            <p className="text-2xl font-medium">{monthDone}</p>
          </div>
        </div>

        <Card className="divide-y divide-stone-100">
          {days.map(([k, v]) => (
            <div key={k} className="px-4 py-3 flex justify-between text-sm">
              <span className="text-stone-600">{k}</span>
              <span className="font-medium">
                {v === "present" ? t("present") : v === "half" ? t("halfDay") : t("leave")}
              </span>
            </div>
          ))}
        </Card>
      </div>
    );
  };

  const Row = ({ label, value, tone }) => (
    <div className="flex justify-between">
      <span className="text-stone-600">{label}</span>
      <span
        className={
          tone === "pos" ? "text-emerald-700" : tone === "neg" ? "text-rose-700" : ""
        }
      >
        {value}
      </span>
    </div>
  );

  const Payments = () => (
    <div className="space-y-4">
      {isHelper && (
        <p className="text-sm text-stone-600 flex gap-2">
          <User size={16} className="shrink-0 mt-0.5" />
          {t("everything")}
        </p>
      )}

      <Card className="overflow-hidden">
        <div className="p-4 space-y-2 text-sm">
          <Row label={t("baseSalary")} value={money(ledger.base)} />
          <Row
            label={`${t("starBonus")} · ${monthStars} ${t("stars")}`}
            value={"+ " + money(ledger.bonus)}
            tone="pos"
          />
          {ledger.leaveCut > 0 && (
            <Row label={t("leaveDeduct")} value={"− " + money(ledger.leaveCut)} tone="neg" />
          )}
          {ledger.adv > 0 && (
            <Row label={t("advances")} value={"− " + money(ledger.adv)} tone="neg" />
          )}
          {ledger.paid > 0 && (
            <Row label={t("paidSoFar")} value={"− " + money(ledger.paid)} tone="neg" />
          )}
        </div>
        <div className="bg-stone-50 px-4 py-4 flex items-baseline justify-between border-t border-stone-200">
          <span className="font-medium">{t("balanceDue")}</span>
          <span className="text-2xl font-medium">{money(ledger.due)}</span>
        </div>
      </Card>

      {!isHelper && (
        <div className="grid grid-cols-2 gap-3">
          <button
            onClick={() => setModal({ kind: "money", type: "payment" })}
            className="py-3 rounded-lg bg-stone-900 text-white text-sm flex items-center justify-center gap-2"
          >
            <Banknote size={16} /> {t("recordPayment")}
          </button>
          <button
            onClick={() => setModal({ kind: "money", type: "advance" })}
            className="py-3 rounded-lg border border-stone-300 text-sm flex items-center justify-center gap-2"
          >
            <Plus size={16} /> {t("addAdvance")}
          </button>
        </div>
      )}

      {isHelper && (
        <button
          onClick={() => update((s) => ({ flags: [...s.flags, { date: d }] }))}
          className="w-full py-3 rounded-lg border-2 border-stone-300 text-sm flex items-center justify-center gap-2"
        >
          <Flag size={16} /> {t("flagIssue")}
        </button>
      )}

      {state.flags.length > 0 && (
        <p className="text-sm text-amber-800 bg-amber-50 rounded-lg p-3">{t("flagged")}</p>
      )}

      <div>
        <p className="text-xs text-stone-500 mb-2">{t("history")}</p>
        <Card className="divide-y divide-stone-100">
          {state.ledger.map((x) => (
            <div key={x.id} className="px-4 py-3 flex justify-between items-center text-sm">
              <div>
                <p>{x.type === "advance" ? t("advances") : t("recordPayment")}</p>
                <p className="text-xs text-stone-500">
                  {x.date}
                  {x.note ? " · " + x.note : ""}
                </p>
              </div>
              <span className="font-medium">{money(x.amount)}</span>
            </div>
          ))}
        </Card>
      </div>
    </div>
  );

  const HelperMonth = () => (
    <div className="space-y-4">
      <div className="grid grid-cols-2 gap-3">
        <div className="bg-emerald-50 rounded-xl p-4">
          <p className="text-sm text-emerald-900">{t("daysWorked")}</p>
          <p className="text-3xl font-medium text-emerald-900">{daysWorked}</p>
        </div>
        <div className="bg-amber-50 rounded-xl p-4">
          <p className="text-sm text-amber-900">{t("stars")}</p>
          <p className="text-3xl font-medium text-amber-900">{monthStars}</p>
        </div>
        <div className="bg-stone-100 rounded-xl p-4">
          <p className="text-sm text-stone-700">{t("tasksDone")}</p>
          <p className="text-3xl font-medium">{monthDone}</p>
        </div>
        <div className="bg-stone-100 rounded-xl p-4">
          <p className="text-sm text-stone-700">{t("earnedSoFar")}</p>
          <p className="text-2xl font-medium">{money(ledger.earned)}</p>
        </div>
      </div>
      <Card className="p-4">
        <p className="text-sm text-stone-600 mb-3">{t("attendance")}</p>
        <div className="flex flex-wrap gap-1.5">
          {Object.entries(state.attendance).map(([k, v]) => (
            <span
              key={k}
              className={`w-9 h-9 rounded-lg flex items-center justify-center text-xs ${
                v === "present"
                  ? "bg-emerald-700 text-white"
                  : v === "half"
                  ? "bg-amber-500 text-white"
                  : "bg-stone-300 text-stone-700"
              }`}
            >
              {k.slice(8)}
            </span>
          ))}
        </div>
      </Card>
    </div>
  );

  const SettingsView = () => (
    <div className="space-y-4">
      <Card className="p-4 space-y-3">
        <Field
          label={t("helperName")}
          value={state.config.name}
          onChange={(v) => update((s) => ({ config: { ...s.config, name: v } }))}
          disabled={isHelper}
        />
        <Field
          label={t("monthlySalary")}
          value={state.config.salary}
          type="number"
          onChange={(v) => update((s) => ({ config: { ...s.config, salary: Number(v) } }))}
          disabled={isHelper}
        />
        <Field
          label={t("hoursPerDay")}
          value={state.config.hours}
          type="number"
          onChange={(v) => update((s) => ({ config: { ...s.config, hours: Number(v) } }))}
          disabled={isHelper}
        />
        <Field
          label={t("perStar")}
          value={state.config.perStar}
          type="number"
          onChange={(v) => update((s) => ({ config: { ...s.config, perStar: Number(v) } }))}
          disabled={isHelper}
        />
      </Card>

      <Card className="p-4">
        <p className="text-sm text-stone-600 mb-3 flex items-center gap-2">
          <Languages size={16} /> {t("language")}
        </p>
        <div className="grid grid-cols-3 gap-2">
          {LANGS.map((l) => (
            <button
              key={l.id}
              onClick={() => setLang(l.id)}
              className={`py-3 rounded-lg text-sm ${
                lang === l.id ? "bg-stone-900 text-white" : "bg-stone-100 text-stone-700"
              }`}
            >
              {l.label}
            </button>
          ))}
        </div>
      </Card>
    </div>
  );

  const Modals = () => {
    if (!modal) return null;

    if (modal === "addTask") {
      return (
        <div className="fixed inset-0 bg-stone-900/50 flex items-end sm:items-center justify-center p-4 z-50">
          <div className="bg-white rounded-t-2xl sm:rounded-2xl w-full max-w-sm max-h-[80vh] overflow-y-auto">
            <div className="sticky top-0 bg-white border-b border-stone-100 px-4 py-3 flex justify-between items-center">
              <h3 className="font-medium">{t("pickTask")}</h3>
              <button onClick={() => setModal(null)} className="p-1 text-stone-400">
                <X size={20} />
              </button>
            </div>
            <div className="p-4 space-y-4">
              <div>
                <p className="text-sm font-medium mb-2">{t("priority")}</p>
                <div className="flex gap-2">
                  <button onClick={() => { addTask("t1", 1); setModal(null); }} className="flex-1 py-2 bg-rose-50 text-rose-800 rounded-lg text-sm">{t("high")}</button>
                  <button onClick={() => { addTask("t1", 0); setModal(null); }} className="flex-1 py-2 bg-stone-100 text-stone-700 rounded-lg text-sm">{t("normal")}</button>
                  <button onClick={() => { addTask("t1", -1); setModal(null); }} className="flex-1 py-2 bg-stone-50 text-stone-500 rounded-lg text-sm">{t("low")}</button>
                </div>
              </div>
              <div className="space-y-2">
                {LIBRARY.map(lib => (
                  <button
                    key={lib.id}
                    onClick={() => { addTask(lib.id, 0); setModal(null); }}
                    className="w-full text-left px-3 py-3 rounded-lg border border-stone-200 flex justify-between items-center"
                  >
                    <span>{lib[lang]}</span>
                    <span className="text-xs text-stone-500">{lib.mins} {t("mins")}</span>
                  </button>
                ))}
              </div>
            </div>
          </div>
        </div>
      );
    }
    return null;
  };

  return (
    <Shell>
      {tab === "today" && role === "owner" && <OwnerToday />}
      {tab === "today" && role === "helper" && <HelperToday />}
      {tab === "att" && role === "owner" && <Attendance />}
      {tab === "month" && role === "helper" && <HelperMonth />}
      {tab === "pay" && <Payments />}
      {tab === "set" && <SettingsView />}
      <Modals />
    </Shell>
  );
}
