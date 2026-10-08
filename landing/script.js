const year = document.getElementById('year');
if (year) year.textContent = new Date().getFullYear();

// Content stays visible if JavaScript or IntersectionObserver is unavailable.
const motionPreference = window.matchMedia('(prefers-reduced-motion: reduce)');
if ('IntersectionObserver' in window && !motionPreference.matches) {
  document.body.classList.add('motion-enabled');
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('in');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.08 });
  document.querySelectorAll('.reveal').forEach((element) => observer.observe(element));
  motionPreference.addEventListener('change', (event) => {
    if (event.matches) document.body.classList.remove('motion-enabled');
  });
}

const solutions = {
  instructions: {
    title: 'One task. Everyone understands.',
    description: 'Write it once. Tasks are translated into Sinhala, Tamil or English, with audio to replay. Clear instructions, without another phone call.',
    preview: '<span class="preview-label">FROM CONFUSION TO CLARITY</span><div class="message-bubble">Please water the garden this evening.<span>House owner · English</span></div><div class="translation-path">↓ <span>Understood, together</span></div><div class="translated-bubble"><span class="si" lang="si">අද සවස වත්තට වතුර දමන්න.</span><div class="audio-wave"><b>▶</b><i></i><i></i><i></i><i></i><i></i><i></i><i></i><i></i><small>Sinhala · audio task</small></div></div>'
  },
  pay: {
    title: 'A shared record. A clearer payday.',
    description: 'Salary, advances and deductions, all in one place. Both people see the same breakdown, so every rupee has a clear explanation.',
    preview: '<span class="preview-label">EXAMPLE · ONE RECORD, BOTH PEOPLE</span><div class="preview-ledger"><div><span>Monthly salary</span><span>Rs 45,000</span></div><div><span>Overtime</span><span>+ Rs 2,000</span></div><div><span>Advance received</span><span>− Rs 5,000</span></div><div><span>Net pay</span><span>Rs 42,000</span></div></div><div class="translation-path">✓ <span>Visible to owner and worker</span></div>'
  },
  workload: {
    title: 'A manageable day. Room to be heard.',
    description: 'Plan recurring tasks and see when the workload is getting heavy. If there’s a water cut, missing supplies or another problem, workers can flag it in a tap.',
    preview: '<span class="preview-label">EXAMPLE · A LITTLE MORE BALANCE</span><div class="preview-status"><strong>Today’s workload · comfortable</strong><p>A shared view of what needs doing.</p><div class="preview-meter"><span></span></div></div><div class="message-bubble">Water cut — cleaning needs to wait.<span>Issue shared with the house owner</span></div>'
  },
  time: {
    title: 'Less remembering. More understanding.',
    description: 'Check in and out, request leave and see approvals in one shared place. Working days and time off stay clear for both people.',
    preview: '<span class="preview-label">EXAMPLE · EVERYONE ON THE SAME PAGE</span><div class="message-bubble">Checked in at 7:58 AM<span>Today’s attendance recorded</span></div><div class="translation-path">↓ <span>Plan ahead, together</span></div><div class="preview-status"><strong>Leave request · Friday</strong><p>Approved by the house owner ✓</p></div>'
  }
};
const tabs = [...document.querySelectorAll('[data-solution]')];
const panel = document.getElementById('solution-panel');
function selectSolution(tab) {
  const solution = solutions[tab.dataset.solution];
  if (!solution || !panel) return;
  tabs.forEach((item) => {
    const selected = item === tab;
    item.classList.toggle('active', selected);
    item.setAttribute('aria-selected', String(selected));
    item.tabIndex = selected ? 0 : -1;
  });
  panel.setAttribute('aria-labelledby', tab.id);
  panel.querySelector('.solution-preview').innerHTML = solution.preview;
  document.getElementById('solution-title').textContent = solution.title;
  document.getElementById('solution-description').textContent = solution.description;
  translateWebsiteElement(panel);
  panel.classList.remove('changing');
  // Restart the short transition only after a deliberate selection.
  requestAnimationFrame(() => panel.classList.add('changing'));
}
tabs.forEach((tab, index) => {
  tab.addEventListener('click', () => selectSolution(tab));
  tab.addEventListener('keydown', (event) => {
    let next;
    if (event.key === 'ArrowDown') next = (index + 1) % tabs.length;
    if (event.key === 'ArrowUp') next = (index - 1 + tabs.length) % tabs.length;
    if (event.key === 'Home') next = 0;
    if (event.key === 'End') next = tabs.length - 1;
    if (next === undefined) return;
    event.preventDefault();
    tabs[next].focus();
    selectSolution(tabs[next]);
  });
});

const languageSelector = document.getElementById('site-language');
languageSelector.addEventListener('change', (event) => {
  setWebsiteLanguage(event.target.value);
  // Start the page over in the new language; html's scroll-behavior decides smooth vs instant.
  window.scrollTo({ top: 0 });
});
let savedLanguage = 'en';
try { savedLanguage = localStorage.getItem('sahakara-language') || 'en'; } catch { /* Use the source language. */ }
setWebsiteLanguage(savedLanguage);

const motionToggle = document.getElementById('motion-toggle');
function setMotionPaused(paused) {
  document.documentElement.dataset.motionPaused = String(paused);
  motionToggle.setAttribute('aria-pressed', String(paused));
  motionToggle.textContent = paused ? 'Resume animations' : 'Pause animations';
  translateWebsiteElement(motionToggle);
  try { localStorage.setItem('sahakara-motion-paused', String(paused)); } catch { /* Session control remains available. */ }
}
motionToggle.addEventListener('click', () => setMotionPaused(motionToggle.getAttribute('aria-pressed') !== 'true'));
try { setMotionPaused(localStorage.getItem('sahakara-motion-paused') === 'true'); } catch { setMotionPaused(false); }

// Mobile menu: the nav links collapse behind a toggle on narrow screens.
const nav = document.querySelector('.nav');
const navToggle = document.querySelector('.nav-toggle');
function setMenuOpen(open) {
  nav.classList.toggle('menu-open', open);
  navToggle.setAttribute('aria-expanded', String(open));
}
navToggle.addEventListener('click', () => setMenuOpen(navToggle.getAttribute('aria-expanded') !== 'true'));
document.querySelectorAll('#site-menu a').forEach((link) => link.addEventListener('click', () => setMenuOpen(false)));
document.addEventListener('keydown', (event) => {
  if (event.key === 'Escape' && nav.classList.contains('menu-open')) { setMenuOpen(false); navToggle.focus(); }
});
document.addEventListener('click', (event) => { if (!nav.contains(event.target)) setMenuOpen(false); });
window.matchMedia('(min-width: 1101px)').addEventListener('change', (event) => { if (event.matches) setMenuOpen(false); });
