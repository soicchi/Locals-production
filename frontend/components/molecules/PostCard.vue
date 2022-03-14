<template>
  <v-container fluid>
    <v-row
      align="center"
      justify="center"
    >
      <v-card
        :width="postCardWidth"
        height="auto"
        class="mb-3 pa-5"
        outlined
      >
        <v-row align="center">
          <v-col
            cols="9"
            class="d-flex align-center"
          >
            <AtomsUserIcon
              :icon-size="iconSize"
              :avatar-url="post.user.avatar_url"
            />
            <AtomsUserName :user="post.user" />
            <AtomsCommonDistanceToNow :date="post.created_at" />
          </v-col>
          <v-spacer />
          <v-col
            v-if="$auth.loggedIn && !myPost"
            cols="2"
            sm="1"
            class="d-flex justify-center"
          >
            <AtomsPostButtonBookMark
              :logged-in-user="loggedInUser"
              :post="post"
            />
          </v-col>
          <v-col
            v-if="$auth.loggedIn && myPost"
            cols="3"
            sm="2"
            class="d-flex justify-end"
          >
            <AtomsPostButtonDestroy
              :post="post"
              @destroy-post="destroyPost"
            />
          </v-col>
        </v-row>
        <v-card-title class="pl-0">
          <AtomsPostRestaurantName :post="post" />
        </v-card-title>
        <template v-if="!$vuetify.breakpoint.xs">
          <v-row class="d-flex">
            <v-col
              v-for="(image, i) in limitCount"
              :key="i"
              cols="4"
              sm="3"
            >
              <v-sheet
                outlined
                width="100%"
                height="100%"
              >
                <AtomsPostImage :image="image" />
              </v-sheet>
            </v-col>
            <v-spacer v-if="!$vuetify.breakpoint.xs" />
            <v-col
              cols="5"
              sm="3"
              align-self="end"
              class="d-flex justify-center"
            >
              <AtomsPostFavoriteRate :post="post" />
            </v-col>
          </v-row>
          <v-row class="d-flex justify-end">
            <v-col>
              <AtomsCategoryItem :categories="post.categories" />
            </v-col>
          </v-row>
        </template>
        <template v-else>
          <v-row class="d-flex">
            <v-col
              v-for="(image, i) in limitCount"
              :key="i"
              cols="4"
              sm="3"
            >
              <v-sheet
                outlined
                width="100%"
                height="100%"
              >
                <AtomsPostImage :image="image" />
              </v-sheet>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="6">
              <AtomsCategoryItem :categories="post.categories" />
            </v-col>
            <v-col
              cols="6"
              align-self="end"
              class="d-flex justify-end"
            >
              <AtomsPostFavoriteRate :post="post" />
            </v-col>
          </v-row>
        </template>
        <v-row class="mb-3">
          <v-col cols="12">
            <p>
              評価ポイント
            </p>
            <v-chip
              v-for="taste in post.tastes"
              :key="taste.id"
              outlined
              class="mr-2 evaluation-chip"
            >
              {{ taste.content }}
            </v-chip>
          </v-col>
        </v-row>
        <v-row
          justify="center"
          class="mb-3"
        >
          <AtomsPostButtonDetail :post-id="post.id" />
        </v-row>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
    postCardWidth: {
      type: String,
      required: true,
    },
  },
  computed: {
    myPost () {
      return this.post.user_id === this.loggedInUser.id
    },
    limitCount () {
      return this.post.image_url.slice(0, 3)
    },
    matchRate () {
      const loggedInUserTastesCount = this.loggedInUser.tastes.length
      const duplicateArray = this.loggedInUser.tastes.concat(this.post.tastes)
      const matchTasteArray = duplicateArray.filter((x, i, array) => {
        return array.findIndex((y) => {
          return y.id === x.id && y.content === x.content
        }) !== i
      })
      return Math.round(matchTasteArray.length / loggedInUserTastesCount * 100)
    },
  },
  methods: {
    destroyPost () {
      this.$emit('destroy-post', this.post)
    },
  },
}
</script>

<style lang="sass" scoped>
  .evaluation-chip::before
    background-color: #fff
</style>
