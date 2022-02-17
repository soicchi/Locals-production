<template>
  <v-app>
    <OrganismsBefHeader />
    <v-main class='background-setting'>
      <OrganismsSnackBar />
      <Nuxt />
    </v-main>
    <OrganismsTheFooter />
  </v-app>
</template>

<style lang="sass" scoped>
  .v-application
    font-family: 'TsukuARdGothic-Regular','M PLUS Rounded 1c', 'Yu Gothic UI', sans-serif
    color: $fontColor
  .background-setting
    background-color: $baseColor
</style>