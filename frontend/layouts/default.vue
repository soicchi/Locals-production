<template>
  <v-app>
    <template v-if="$auth.loggedIn">
      <OrganismsTheHeader />
    </template>
    <template v-else>
      <OrganismsBefHeader />
    </template>
    <v-main class="background-setting">
      <OrganismsSnackBar />
      <Nuxt />
    </v-main>
    <OrganismsTheFooter />
  </v-app>
</template>

<style lang="sass" scoped>
  .v-application
    color: $fontColor
  .background-setting
    background-color: $baseColor
</style>
