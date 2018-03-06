/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Contacts",
      contacts: []
    };
  },
  mounted: function() {
    axios.get("/contacts").then(
      function(response) {
        this.contacts = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var ContactsShowPage = {
  template: "#contacts-show-page",
  data: function() {
    return {
      contact: {
        first_name: "Sample first name",
        last_name: "Sample last name",
        email: "Sample email",
        phone_number: "",
        bio: "Sample bio"
      }
    };
  },
  mounted: function() {
    axios.get("/contacts/" + this.$route.params.id).then(
      function(response) {
        this.contact = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var ContactsNewPage = {
  template: "#contacts-new-page",
  data: function() {
    return {
      firstName: "",
      middleName: "",
      lastName: "",
      email: "",
      phoneNumber: "",
      bio: "",
      errors: []
    };
  },
  mounted: function() {},
  methods: {
    submit: function() {
      var params = {
        first_name: this.firstName,
        middle_name: this.middleName,
        last_name: this.lastName,
        email: this.email,
        phone_number: this.phoneNumber,
        bio: this.bio
      };
      axios
        .post("/contacts", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var ContactsUpdatePage = {
  template: "#contacts-update-page",
  data: function() {
    return {
      firstName: "",
      middleName: "",
      lastName: "",
      email: "",
      phoneNumber: "",
      bio: "",
      errors: []
    };
  },
  mounted: function() {},
  methods: {
    submit: function() {
      var params = {
        first_name: this.firstName,
        middle_name: this.middleName,
        last_name: this.lastName,
        email: this.email,
        phone_number: this.phoneNumber,
        bio: this.bio
      };
      axios
        .patch("/contacts/" + this.$route.params.id, params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/contacts/update/:id", component: ContactsUpdatePage },
    { path: "/contacts/new", component: ContactsNewPage },
    { path: "/contacts/:id", component: ContactsShowPage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
