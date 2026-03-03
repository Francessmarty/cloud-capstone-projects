function wireForms() {
  const loginForm = document.getElementById("loginForm");
  const signupForm = document.getElementById("signupForm");

  if (loginForm) {
    loginForm.addEventListener("submit", async (e) => {
      e.preventDefault();
      const msg = document.getElementById("loginMessage");

      const email = loginForm.querySelector("input[type=email]").value;
      const password = loginForm.querySelector("input[type=password]").value;

      try {
        const res = await fetch("/api/login", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ email, password })
        });

        const data = await res.json();
        msg.textContent = data.message;
      } catch (err) {
        msg.textContent = "Login failed.";
      }
    });
  }

  if (signupForm) {
    signupForm.addEventListener("submit", async (e) => {
      e.preventDefault();
      const msg = document.getElementById("signupMessage");

      const name = signupForm.querySelector("input[type=text]").value;
      const email = signupForm.querySelector("input[type=email]").value;
      const password = signupForm.querySelector("input[type=password]").value;

      try {
        const res = await fetch("/api/signup", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ name, email, password })
        });

        const data = await res.json();
        msg.textContent = data.message;
      } catch (err) {
        msg.textContent = "Signup failed.";
      }
    });
  }
}

document.addEventListener("DOMContentLoaded", () => {
  wireHome();
  wireForms();
});