<template>
  <MoleculesFormCard
    :is-valid.sync="setIsValid"
    :card-width="cardWidth"
  >
    <template #form-title>
      <h2>投稿作成</h2>
    </template>
    <template #form-card-content>
      <AtomsFormRestaurantName :restaurant-name.sync="setPost.restaurant_name" />
      <AtomsFormStation :station.sync="setPost.station" />
      <AtomsFormCategory
        :category-ids.sync="setPost.category_ids"
        :category-items="categoryItems"
      />
      <AtomsFormImage :images.sync="setPost.images" />
      <AtomsFormComment :comment.sync="setPost.comment" />
    </template>
    <template #form-card-button>
      <v-btn
        :disabled="!isValid"
        text
        plain
        @click="next"
      >
        次へ
      </v-btn>
    </template>
  </MoleculesFormCard>
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
    next () {
      this.$emit('next')
    },
  },
}
</script>
