<template>
  <v-container fluid>
    <v-row
      justify="center"
      align="center"
    >
      <v-card
        :width="cardWidth"
        class="mt-5 pa-5"
        height="auto"
        flat
        color="baseColor"
      >
        <v-row align="center">
          <v-col
            cols="8"
            sm="3"
            class="d-flex align-center"
          >
            <AtomsUserIcon
              :icon-size="iconSize"
              :avatar-url="post.user.avatar_url"
            />
            <AtomsUserName :user="post.user" />
            <AtomsCommonDate :date="post.created_at" />
          </v-col>
          <v-spacer />
          <v-col
            v-if="loggedInUser.id !== post.user_id && $auth.loggedIn"
            cols="2"
            sm="1"
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
          <v-col cols="12">
            <p>評価ポイント</p>
            <v-chip
              v-for="taste in post.tastes"
              :key="taste.id"
              outlined
              class="mr-2"
            >
              {{ taste.content }}
            </v-chip>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12">
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
          <v-col
            cols="12"
            md="6"
          >
            <AtomsPostComment :post="post" />
          </v-col>
          <v-col
            cols="6"
            sm="3"
            md="2"
            xl="1"
          >
            <AtomsPostFavoriteRate :post="post" />
          </v-col>
          <v-col
            cols="3"
            sm="2"
            md="2"
            lg="1"
            align-self="end"
            class="px-0"
          >
            <AtomsPostButtonLike
              :post="post"
              :logged-in-user="loggedInUser"
              :liked="liked"
              :my-post="myPost"
              @change-to-liked="changeToLiked"
            />
            <p class="text-center">
              <span :style="fontSize">また行きたい!</span>
            </p>
          </v-col>
          <v-col
            cols="3"
            sm="2"
            md="2"
            lg="1"
            align-self="end"
            class="px-0"
          >
            <AtomsPostButtonDislike
              :post="post"
              :logged-in-user="loggedInUser"
              :disliked="disliked"
              :my-post="myPost"
              @change-to-disliked="changeToDisliked"
            />
            <p class="bad text-center">
              <span :style="fontSize">う〜ん...</span>
            </p>
          </v-col>
        </v-row>
      </v-card>
    </v-row>
    <v-row
      justify="center"
      class="mb-3"
    >
      <v-col
        cols="12"
        sm="5"
      >
        <MoleculesPostChart
          :favorite-rate-group="favoriteRateGroup"
          :width="width"
          :height="height"
        />
      </v-col>
      <v-col
        cols="12"
        sm="5"
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
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '80%'
    },
    fontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '7px' } : { 'font-size': '12px' }
    },
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
  .swiper-button-prev,
  .swiper-button-next
    --swiper-navigation-color: #58554e
</style>
