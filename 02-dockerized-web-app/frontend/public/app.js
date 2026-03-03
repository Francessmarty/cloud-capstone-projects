document.addEventListener("DOMContentLoaded", () => {
  console.log("APP JS LOADED ON:", location.pathname);

  // IMPORTANT:
  // Use relative /api paths so nginx can proxy to backend inside docker network.
  // DO NOT use http://localhost:5000 in the browser when running behind nginx.

  const loginForm = document.getElementById("loginForm");
  const signupForm = document.getElementById("signupForm");

  
 
  const logoutBtn =
    document.getElementById("logoutBtn") || document.getElementById("logoutBtn");

  //  LOGIN 
  if (loginForm) {
    loginForm.addEventListener("submit", async (e) => {
      e.preventDefault();

      const msg = document.getElementById("loginMessage");
      if (msg) msg.textContent = "";

      const email = loginForm.querySelector("input[name=email]")?.value?.trim();
      const username = loginForm.querySelector("input[name=username]")?.value?.trim();
      const password = loginForm.querySelector("input[name=password]")?.value;

      if (!email || !password) {
        if (msg) msg.textContent = "Email, username and password required.";
        return;
      }

      try {
        const res = await fetch("/api/login", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ email, username, password }),
        });

        // safely parse json
        let data = {};
        try {
          data = await res.json();
        } catch (_) {}

        if (res.ok) {
          if (msg) msg.textContent = data.message || "Successfully Logged in";
          setTimeout(() => {
            window.location.href = "dashboard.html";
          }, 600);
        } else {
          if (msg) msg.textContent = data.message || "Login failed.";
        }
      } catch (err) {
        if (msg) msg.textContent = "Login failed.";
      }
    });
  }

  //  SIGNUP 
  if (signupForm) {
    signupForm.addEventListener("submit", async (e) => {
      e.preventDefault();

      const msg = document.getElementById("signupMessage");
      if (msg) msg.textContent = "";

      const name = signupForm.querySelector("input[name=name]")?.value?.trim();
      const email = signupForm.querySelector("input[name=email]")?.value?.trim();
      const username = signupForm.querySelector("input[name=username]")?.value?.trim();
      const password = signupForm.querySelector("input[name=password]")?.value;

      if (!name || !email || !password) {
        if (msg) msg.textContent = "Name, email and password required.";
        return;
      }

      try {
        const res = await fetch("/api/signup", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ name, email, password }),
        });

        let data = {};
        try {
          data = await res.json();
        } catch (_) {}

        if (res.ok) {
          if (msg) msg.textContent = data.message || "Account Successfully Created";
          
          setTimeout(() => {
            window.location.href = "dashboard.html";
          }, 800);
        } else {
          if (msg) msg.textContent = data.message || "Signup failed.";
        }
      } catch (err) {
        if (msg) msg.textContent = "Signup failed.";
      }
    });
  }
   


  // LOGOUT 
  // 
  const realLogoutBtn =
    document.getElementById("logoutBtn") || document.getElementById("logoutBtn");

  if (realLogoutBtn) {
    realLogoutBtn.addEventListener("click", () => {
      window.location.href = "index.html";
    });
  }
});