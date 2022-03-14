<template>
  <div>
    <transition
      mode="out-in"
      :name="transitionName"
    >
      <component
        :is="subPage"
        :post.sync="setPost"
        :is-valid.sync="setIsValid"
        :category-items="categoryItems"
        :sub-page="subPage"
        :card-width="cardWidth"
        :evaluation-list="evaluationList"
        :loading="loading"
        @create-post="createPost"
        @next="next"
        @back="back"
      />
    </transition>
  </div>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
      default: null,
    },
    isValid: {
      type: Boolean,
      required: true,
      default: false,
    },
    categoryItems: {
      type: Array,
      required: true,
    },
    cardWidth: {
      type: String,
      required: true,
    },
    subPage: {
      type: Object,
      required: true,
    },
    transitionName: {
      type: String,
      required: true,
    },
    evaluationList: {
      type: Array,
      required: true,
    },
    loading: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  computed: {
    setPost: {
      get () { return this.post },
      set (newVal) { return this.$emit('update:post', newVal) },
    },
    setIsValid: {
      get () { return this.isValid },
      set (newVal) { return this.$emit('update:isValid', newVal) },
    },
  },
  methods: {
    createPost () {
      this.$emit('create-post')
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
