// --- DOM Elements ---
const typingTextEl = document.getElementById('typing-text');
const menuBtn = document.querySelector('.menu-btn');
const mobileDrawer = document.querySelector('.mobile-drawer');
const navLinks = document.querySelectorAll('.nav-link');
const drawerLinks = document.querySelectorAll('.drawer-link');
const sections = document.querySelectorAll('.section');
const projectCards = document.querySelectorAll('.project-card');
const companyModal = document.getElementById('company-project-modal');
const modalCloseBtn = document.getElementById('modal-close-btn');
const contactForm = document.getElementById('contact-form');
const contactTiles = document.querySelectorAll('.contact-tile');

// --- 1. Typing Animation ---
const roles = [
  "Software Engineer",
  "Flutter Developer",
  "AI/ML Enthusiast",
  "Full Stack Developer"
];

let roleIndex = 0;
let charIndex = 0;
let isDeleting = false;
let typingDelay = 100;
let deletingDelay = 50;
let pauseDelay = 1500;

function type() {
  const currentRole = roles[roleIndex];
  
  if (isDeleting) {
    // Deleting character
    typingTextEl.textContent = currentRole.substring(0, charIndex - 1);
    charIndex--;
    typingTextEl.classList.add('typing-cursor');
    
    if (charIndex === 0) {
      isDeleting = false;
      roleIndex = (roleIndex + 1) % roles.length;
      setTimeout(type, 200);
    } else {
      setTimeout(type, deletingDelay);
    }
  } else {
    // Typing character
    typingTextEl.textContent = currentRole.substring(0, charIndex + 1);
    charIndex++;
    typingTextEl.classList.add('typing-cursor');
    
    if (charIndex === currentRole.length) {
      isDeleting = true;
      // Pause at complete word
      setTimeout(type, pauseDelay);
    } else {
      setTimeout(type, typingDelay);
    }
  }
}

// Start typing loop
document.addEventListener('DOMContentLoaded', () => {
  if (typingTextEl) {
    type();
  }
});

// --- 2. Mobile Drawer Navigation ---
function toggleDrawer() {
  menuBtn.classList.toggle('open');
  mobileDrawer.classList.toggle('open');
}

if (menuBtn) {
  menuBtn.addEventListener('click', toggleDrawer);
}

// Close drawer on link click
drawerLinks.forEach(link => {
  link.addEventListener('click', () => {
    menuBtn.classList.remove('open');
    mobileDrawer.classList.remove('open');
  });
});

// --- 3. Scroll Spy (Active Links Highlight) ---
const observerOptions = {
  root: null,
  rootMargin: '-30% 0px -70% 0px', // Trigger when section occupies the active middle portion
  threshold: 0
};

const observerCallback = (entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const activeId = entry.target.getAttribute('id');
      
      // Update Navbar Links
      navLinks.forEach(link => {
        if (link.getAttribute('href') === `#${activeId}`) {
          link.classList.add('active');
        } else {
          link.classList.remove('active');
        }
      });

      // Update Mobile Drawer Links
      drawerLinks.forEach(link => {
        if (link.getAttribute('href') === `#${activeId}`) {
          link.classList.add('active');
        } else {
          link.classList.remove('active');
        }
      });
    }
  });
};

const observer = new IntersectionObserver(observerCallback, observerOptions);
sections.forEach(section => observer.observe(section));

// --- 4. Interactive Project Card Click Handlers ---
projectCards.forEach(card => {
  card.addEventListener('click', () => {
    const isCompany = card.getAttribute('data-company') === 'true';
    if (isCompany) {
      // Open restricted modal popup
      companyModal.classList.add('open');
    } else {
      // Open GitHub project url
      const url = card.getAttribute('data-url');
      if (url) {
        window.open(url, '_blank', 'noopener,noreferrer');
      }
    }
  });
});

// Close restricted modal
if (modalCloseBtn) {
  modalCloseBtn.addEventListener('click', () => {
    companyModal.classList.remove('open');
  });
}

// Close modal when clicking outside card
if (companyModal) {
  companyModal.addEventListener('click', (e) => {
    if (e.target === companyModal) {
      companyModal.classList.remove('open');
    }
  });
}

// --- 5. Contact Section Tiles & Form Composition ---

// Direct contact tiles trigger href actions
contactTiles.forEach(tile => {
  tile.addEventListener('click', () => {
    const action = tile.getAttribute('data-action');
    if (action) {
      window.open(action, '_blank', 'noopener,noreferrer');
    }
  });
});

// Form submit compose email client draft
if (contactForm) {
  contactForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    const name = document.getElementById('form-name').value;
    const email = document.getElementById('form-email').value;
    const message = document.getElementById('form-message').value;

    const subject = encodeURIComponent(`Portfolio Contact from ${name}`);
    const body = encodeURIComponent(`From: ${email}\n\nMessage:\n${message}`);
    const mailtoUrl = `mailto:shyam2003raj666@gmail.com?subject=${subject}&body=${body}`;
    
    // Trigger mail client opening
    window.location.href = mailtoUrl;

    // Optional alert indicating mailto launching
    alert("Opening your default mail application to draft the message!");

    contactForm.reset();
  });
}
