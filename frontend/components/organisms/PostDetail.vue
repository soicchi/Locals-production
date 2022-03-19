<template>
  <v-container>
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
            <p class="mb-1">
              評価ポイント
              <span
                v-if="post.user_id !== loggedInUser.id && $auth.loggedIn"
                class="text-h6 ml-3"
              >
                マッチ度
                <v-icon
                  color="mainColor"
                  class="pb-2"
                >
                  mdi-handshake-outline
                </v-icon>
                {{ matchRate }}%
              </span>
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
            xl="2"
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
              <span class="btn-text">また行きたい!</span>
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
              <span class="btn-text">う〜ん...</span>
            </p>
          </v-col>
        </v-row>
      </v-card>
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
    swiperOptions: {
      type: Object,
      required: true,
    },
    cardWidth: {
      type: String,
      required: true,
    },
  },
  computed: {
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
  .btn-text
    font-size: 7px
  .swiper-button-prev,
  .swiper-button-next
    --swiper-navigation-color: #58554e
  .evaluation-chip::before
    background-color: #fff
</style>
