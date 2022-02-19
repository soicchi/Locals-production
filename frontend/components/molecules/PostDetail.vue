<template>
  <v-container fluid>
    <v-row
      justify="center"
      align="center"
    >
      <v-card
        width="80%"
        class="mt-5 pa-5"
        height="auto"
        flat
        color="baseColor"
      >
        <v-row align="center">
          <v-col cols="1">
            <AtomsUserIcon
              :icon-size="iconSize"
              :avatar-url="post.user.avatar_url"
            />
          </v-col>
          <v-col cols="2">
            <AtomsUserName :user="post.user" />
          </v-col>
          <v-spacer />
          <v-col
            v-if="loggedInUser.id !== post.user_id && $auth.loggedIn"
            cols="1"
          >
            <AtomsPostButtonBookMark
              :post="post"
              :logged-in-user="loggedInUser"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12">
            <AtomsPostRestaurantName :post="post" />
          </v-col>
          <v-col cols="12">
            <AtomsCategoryItem :categories="post.categories" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="10">
            <swiper :options="swiperOptions">
              <swiper-slide
                v-for="(image, i) in post.image_url"
                :key="i"
              >
                <v-sheet
                  outlined
                  width="200"
                  height="200"
                >
                  <AtomsPostImage :image="image" />
                </v-sheet>
              </swiper-slide>
              <div slot="pagination" class="swiper-pagination" />
              <div slot="button-prev" class="swiper-button-prev" />
              <div slot="button-next" class="swiper-button-next" />
            </swiper>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="6">
            <AtomsPostComment :post="post" />
          </v-col>
          <v-col cols="2">
            <AtomsPostFavoriteRate :post="post" />
          </v-col>
          <v-col
            cols="1"
            align-self="center"
            class="mt-8"
          >
            <AtomsPostButtonLike
              :post="post"
              :logged-in-user="loggedInUser"
              :liked="liked"
              :my-post="myPost"
              @change-to-liked="changeToLiked"
            />
            <p class="btn-font">
              また行きたい!
            </p>
          </v-col>
          <v-col
            cols="1"
            align-self="center"
            class="mt-8"
          >
            <AtomsPostButtonDislike
              :post="post"
              :logged-in-user="loggedInUser"
              :disliked="disliked"
              :my-post="myPost"
              @change-to-disliked="changeToDisliked"
            />
            <p class="btn-font bad">
              う〜ん...
            </p>
          </v-col>
        </v-row>
      </v-card>
    </v-row>
    <v-row justify="center">
      <v-col cols="5">
        <MoleculesPostChart
          :favorite-rate-group="favoriteRateGroup"
          :width="width"
          :height="height"
        />
      </v-col>
      <v-col
        cols="4"
        class="mt-8"
      >
        <MoleculesPostMap
          :restaurant-name="post.restaurant_name"
          :station="post.station"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    iconSize: {
      type: Number,
      required: true,
    },
    post: {
      type: Object,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    liked: {
      type: Boolean,
      required: true,
      default: false,
    },
    disliked: {
      type: Boolean,
      required: true,
      default: false,
    },
    myPost: {
      type: Boolean,
      required: true,
      default: false,
    },
    favoriteRateGroup: {
      type: Array,
      required: true,
    },
  },
  data () {
    return {
      swiperOptions: {
        width: 200,
        spaceBetween: 40,
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
        pagination: {
          el: '.swiper-pagination',
          clickable: true,
        },
      },
    }
  },
  computed: {
    width: () => 500,
    height: () => 350,
  },
  methods: {
    changeToLiked (postId) {
      this.$emit('change-to-liked', postId)
    },
    changeToDisliked (postId) {
      this.$emit('change-to-disliked', postId)
    },
  },
}
</script>

<style lang="sass" scoped>
  .btn-font
    font-size: 12px
  .bad
    padding-left: 12px
</style>
