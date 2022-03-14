<template>
  <div>
    <transition
      mode="out-in"
      :name="transitionName"
    >
      <component
        :is="subPage"
        :user.sync="setUser"
        :no-validation="noValidation"
        :is-valid.sync="setIsValid"
        :sub-page="subPage"
        :preference-list="preferenceList"
        :card-width="cardWidth"
        @sign-up="signUp"
        @reset-day="resetDay"
        @next="next"
        @back="back"
      />
    </transition>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      requried: true,
      default: null,
    },
    noValidation: {
      type: Boolean,
      required: true,
      default: false,
    },
    isValid: {
      type: Boolean,
      required: true,
      default: false,
    },
    subPage: {
      type: Object,
      required: true,
    },
    preferenceList: {
      type: Array,
      required: true,
    },
    transitionName: {
      type: String,
      required: true,
    },
    cardWidth: {
      type: String,
      required: true,
    },
  },
  computed: {
    setUser: {
      get () { return this.user },
      set (newVal) { return this.$emit('update:user', newVal) },
    },
    setIsValid: {
      get () { return this.isValid },
      set (newVal) { return this.$emit('update:isValid', newVal) },
    },
    setCheckboxIds: {
      get () { return this.checkboxIds },
      set (newVal) { return this.$emit('update:checkboxIds', newVal) },
    },
  },
  methods: {
    signUp () {
      this.$emit('sign-up')
    },
    resetDay () {
      this.$emit('reset-day')
    },
    next () {
      this.$emit('next')
    },
    back () {
      this.$emit('back')
    },
  },
}
</script>

<style lang='sass' scoped>
.slide-next-enter-active,
.slide-next-leave-active,
.slide-back-enter-active,
.slide-back-leave-active
  transition: all 0.15s ease

.slide-next-enter,
.slide-back-leave-to
  transform: translateX(20%)
  opacity: 0

.slide-next-leave-to,
.slide-back-enter
  transform: translateX(-20%)
  opacity: 0
</style>
