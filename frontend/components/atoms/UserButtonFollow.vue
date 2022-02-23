<template>
  <div v-if="loggedInUser && loggedInUser.id !== user.id">
    <v-btn
      v-if="!followed"
      class="follow-btn"
      color="mainColor"
      rounded
      :loading="loading"
      :disabled="loading"
      @click="follow"
      :style='fontSize'
    >
      フォロー
    </v-btn>
    <v-btn
      v-if="followed"
      color="subColor"
      rounded
      class="follow-btn"
      :loading="loading"
      :disabled="loading"
      @click="unfollow"
      :style='fontSize'
    >
      フォロー解除
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
    }
  },
  created () {
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
  .follow-btn
    @include commonBtn
</style>
