<template>
  <div>
    <v-row>
      <OrganismsPostDetail
        :icon-size="iconSize"
        :post="post"
        :logged-in-user="loggedInUser"
        :liked="liked"
        :disliked="disliked"
        :my-post="myPost"
        :swiper-options="swiperOptions"
        :match-rate="matchRate"
        :card-width="cardWidth"
        @change-to-liked="changeToLiked"
        @change-to-disliked="changeToDisliked"
      />
    </v-row>
    <v-container>
      <v-row
        justify="center"
        class="mb-3"
      >
        <v-col
          cols="12"
          sm="5"
        >
          <!-- <v-carousel
            hide-delimiter-background
            continuous
          >
            <v-carousel-item> -->
          <OrganismsPostBarChart
            :favorite-rate-group="post.favorite_rate_group"
            :width="chartWidth"
            :height="chartHeight"
          />
          <!-- </v-carousel-item>
            <v-carousel-item>
              <OrganismsPostCircleChart
                :width="chartWidth"
                :height="chartHeight"
              />
            </v-carousel-item>
          </v-carousel> -->
        </v-col>
        <v-col
          cols="12"
          sm="5"
          class="mt-8"
        >
          <OrganismsPostMap
            :restaurant-name="post.restaurant_name"
            :station="post.station"
          />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  props: {
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
    myPost: {
      type: Boolean,
      required: true,
      default: false,
    },
    swiperOptions: {
      type: Object,
      required: true,
    },
    matchRate: {
      type: Number,
      required: true,
    },
    chartWidth: {
      type: Number,
      required: true,
    },
    chartHeight: {
      type: Number,
      required: true,
    },
    cardWidth: {
      type: String,
      required: true,
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
