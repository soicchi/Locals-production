<template>
  <TemplatesPostPage
    :liked="liked"
    :disliked="disliked"
    :post="post"
    :logged-in-user="loggedInUser"
    :icon-size="iconSize"
    :my-post="myPost"
    :swiper-options="swiperOptions"
    :chart-width="chartWidth"
    :chart-height="chartHeight"
    :card-width="cardWidth"
    @change-to-liked="changeToLiked"
    @change-to-disliked="changeToDisliked"
  />
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  async asyncData ({ params, $axios, store }) {
    await $axios.get(`/posts/${params.id}`)
      .then((res) => {
        store.commit('post/setPost', res.data)
      })
  },
  data: () => ({
    liked: false,
    disliked: false,
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
  }),
  computed: {
    ...mapGetters({
      post: 'post/post',
      loggedInUser: 'user/loggedInUser',
    }),
    iconSize: () => 48,
    chartWidth: () => 500,
    chartHeight: () => 350,
    myPost () {
      return this.loggedInUser.id === this.post.user_id
    },
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '80%'
    },
  },
  methods: {
    changeToLiked (postId) {
      this.liked = !this.liked
      if (this.disliked) {
        this.disliked = false
        this.$store.dispatch('user/removeLoggedInUserDislikedPost', postId)
        this.$store.dispatch('post/removeDislikeUser', this.loggedInUser)
      }
    },
    changeToDisliked (postId) {
      this.disliked = !this.disliked
      if (this.liked) {
        this.liked = false
        this.$store.dispatch('user/removeLoggedInUserLikedPost', postId)
        this.$store.dispatch('post/removeLikeUser', this.loggedInUser)
      }
    },
  },
}
</script>
