import { createPinia } from "pinia";
import { createApp } from "vue";
import App from "./App.vue";
import router, { RouteName } from "./router";
import { useAuth } from "./views/auth/AuthStore";
import { useConfig } from "./components/config/ConfigStore";
import piniaPluginPersistedstate from "pinia-plugin-persistedstate";

const app = createApp(App);
const pinia = createPinia();

function syncLS(key: string, value: string): void {
  if (!localStorage.getItem(key)) localStorage.setItem(key, value);
}

app.use(pinia);
pinia.use(piniaPluginPersistedstate);
app.use(router);

useAuth()
  .refresh()
  .then((done) => {
    if (done) {
      app.mount("#app");
      syncLS("beardify-config", JSON.stringify(useConfig().$state));
      useConfig().switchScheme(useConfig().schemeLabel);
      useConfig().switchTheme(useConfig().themeLabel);
    }
  })
  .catch(() => {
    app.mount("#app");
    router.push(`${RouteName.Login}?ref=${window.location.pathname}`);
  });
