<template>
  <v-row>
    <v-col cols="6">
      <v-select
        v-model="setBirthYear"
        label="生年月日 西暦"
        :items="birthYears"
        :rules="rules"
        :prepend-icon="mdiCake"
        @change="resetDay"
      />
    </v-col>
    <v-col cols="3">
      <v-select
        v-model="setBirthMonth"
        label="月"
        :items="birthMonths"
        :rules="rules"
        @change="resetDay"
      />
    </v-col>
    <v-col cols="3">
      <v-select
        v-model="setBirthDay"
        label="日"
        :rules="rules"
        :items="birthDays"
      />
    </v-col>
  </v-row>
</template>

<script>
import { mdiCake } from '@mdi/js'

export default {
  props: {
    birthYear: {
      type: Number,
      required: true,
    },
    birthMonth: {
      type: Number,
      required: true,
    },
    birthDay: {
      type: Number,
      required: true,
    },
  },
  data: () => ({
    mdiCake,
  }),
  computed: {
    rules () {
      return [v => !!v || '']
    },
    birthYears () {
      const years = []
      for (let year = 1920; year <= new Date().getFullYear(); year++) {
        years.push(year)
      }
      return years.reverse()
    },
    birthMonths () {
      const months = [...Array(12)].map((v, i) => i + 1)
      return months
    },
    birthDays () {
      let days = []
      if (this.month === 2 && this.year % 4 === 0 && this.year % 100 === 0 && this.year % 400 !== 0) {
        days = [...Array(29)].map((v, i) => i + 1)
      } else if (this.month === 2) {
        days = [...Array(28)].map((v, i) => i + 1)
      } else if (this.month === 2 || this.month === 4 || this.month === 6 || this.month === 9 || this.month === 11) {
        days = [...Array(30)].map((v, i) => i + 1)
      } else {
        days = [...Array(31)].map((v, i) => i + 1)
      }
      return days
    },
    setBirthYear: {
      get () { return this.birthYear },
      set (newVal) { return this.$emit('update:birthYear', newVal) },
    },
    setBirthMonth: {
      get () { return this.birthMonth },
      set (newVal) { return this.$emit('update:birthMonth', newVal) },
    },
    setBirthDay: {
      get () { return this.birthDay },
      set (newVal) { return this.$emit('update:birthDay', newVal) },
    },
  },
  methods: {
    resetDay () {
      this.$emit('resetDay')
    },
  },
}
</script>
