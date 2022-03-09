<template>
  <v-container>
    <v-row
      justify="center"
      class="mt-5"
    >
      <h1>管理画面</h1>
    </v-row>
    <v-row justify="center">
      <v-col cols="3" class="mt-14 pt-14">
        <OrganismsAdminCategory
          :categories="categories"
          :category.sync="category"
          @add-category="addCategory" 
        />
      </v-col>
      <v-col cols="6">
        <OrganismsAdminPost
          :posts="posts"
          :icon-size="iconSize"
          :sort-val="sortVal"
          :sort-list="sortList"
          @destroy-post="destroyPost"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    posts: {
      type: Array,
      required: true,
    },
    categories: {
      type: Array,
      required: true,
    },
    category: {
      type: String,
      required: true,
      default: '',
    },
    iconSize: {
      type: Number,
      required: true,
    },
    sortVal: {
      type: String,
      rquired: true,
      default: '本日',
    },
    sortList: {
      type: Array,
      required: true,
    },
  },
  methods: {
    addCategory () {
      this.$emit('add-category')
    },
    destroyPost () {
      this.$emit('destroy-post')
    },
  }
}
</script>