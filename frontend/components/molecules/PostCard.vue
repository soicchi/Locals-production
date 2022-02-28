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
            cols="2"
            sm="1"
          >
            <AtomsUserIcon
              :icon-size="iconSize"
              :avatar-url="post.user.avatar_url"
            />
          </v-col>
          <v-col
            cols="3"
            sm="2"
            class="pl-0"
          >
            <slot name="post-card-user-name" />
          </v-col>
          <v-spacer />
          <v-col
            cols="4"
            class="d-flex justify-center"
            sm="3"
          >
            <AtomsCommonDate :date="post.created_at" />
          </v-col>
          <v-col
            v-if="$auth.loggedIn && !myPost"
            cols="3"
            sm="2"
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
            class="d-flex justify-center"
          >
            <AtomsPostButtonDestroy
              :post="post"
              @destroy-post="destroyPost"
            />
          </v-col>
        </v-row>
        <V-card-title class="pl-0">
          <AtomsPostRestaurantName :post="post" />
        </V-card-title>
        <v-row class="d-flex">
          <div
            v-for="(image, i) in limitCount"
            :key="i"
          >
            <v-col
              cols="6"
              sm="3"
            >
              <v-sheet
                outlined
                :width="imageWidth"
                :height="imageHeight"
              >
                <AtomsPostImage :image="image" />
              </v-sheet>
            </v-col>
          </div>

          <!-- mobile版レイアウト用 -->
          <v-col
            v-if="$vuetify.breakpoint.xs"
            cols="6"
          >
            <AtomsCategoryItem :categories="post.categories" />
          </v-col>
          <!-- mobile版レイアウト用 -->

          <v-spacer v-if="!$vuetify.breakpoint.xs" />
          <v-col
            cols="6"
            sm="3"
            align-self="end"
          >
            <!-- <AtomsPostViews /> -->
            <AtomsPostFavoriteRate :post="post" />
          </v-col>
        </v-row>
        <template v-if="!$vuetify.breakpoint.xs">
          <v-row class="d-flex justify-end">
            <v-col>
              <AtomsCategoryItem :categories="post.categories" />
            </v-col>
            <v-spacer />
          </v-row>
        </template>
        <v-row
          justify="center"
          class="mb-5"
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
  },
  computed: {
    myPost () {
      return this.post.user_id === this.loggedInUser.id
    },
    limitCount () {
      return this.$vuetify.breakpoint.xs ? this.post.image_url.slice(0, 2) : this.post.image_url.slice(0, 3)
    },
    imageWidth () {
      return this.$vuetify.breakpoint.xs ? '120px' : '200px'
    },
    imageHeight () {
      return this.$vuetify.breakpoint.xs ? '100px' : '200px'
    },
    postCardWidth () {
      return this.$vuetify.breakpoint.xs ? '100%' : '45%'
    },
  },
  methods: {
    destroyPost () {
      this.$emit('destroy-post', this.post)
    },
  },
}
</script>
