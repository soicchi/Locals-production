<template>
  <div v-if="loggedInUser && loggedInUser.id !== user.id && $auth.loggedIn">
    <v-btn
      v-if="!followed"
      class="follow-btn px-5"
      color="mainColor"
      rounded
      :loading="loading"
      :disabled="loading"
      :style="fontSize"
      @click="follow"
    >
      フォローする
    </v-btn>
    <v-btn
      v-if="followed"
      color="subColor"
      rounded
      class="unfollow-btn px-5"
      :loading="loading"
      :disabled="loading"
      :style="fontSize"
      @click="unfollow"
    >
      フォロー中
    </v-btn>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  props: {
    loggedInUser: {
      type: Object,
      required: true,
    },
    user: {
      type: Object,
      required: true,
    },
  },
  data () {
    return {
      loading: false,
      followed: false,
    }
  },
  computed: {
    fontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '12px' } : ''
    },
  },
  created () {
    if (this.$auth.loggedIn) {
      this.loading = true
      setTimeout(() => {
        const followedState = this.loggedInUser.following.some((following) => {
          return following.id === this.user.id
        })
        if (followedState) {
          this.followed = true
        }
        this.loading = false
      }, 1500)
    }
  },
  methods: {
    ...mapActions({
      addFollower: 'relationShip/addFollower',
      addLoggedInUserFollowing: 'user/addLoggedInUserFollowing',
      removeFollower: 'relationShip/removeFollower',
      removeLoggedInUserFollowing: 'user/removeLoggedInUserFollowing',
    }),
    async follow () {
      this.followed = true
      await this.$axios.post('/relationships', { user_id: this.user.id })
        .then(() => {
          this.addLoggedInUserFollowing(this.user)
        })
    },
    async unfollow () {
      this.followed = false
      await this.$axios.delete(`/relationships/${this.user.id}`)
        .then((res) => {
          this.removeLoggedInUserFollowing(this.user)
        })
    },
  },
}
</script>

<style lang="sass" scoped>
  .follow-btn,
  .unfollow-btn
    @include commonBtn
  .unfollow-btn
    letter-spacing: 3.5px
</style>
