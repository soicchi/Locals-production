<template>
  <v-container fluid>
    <v-row
      justify="center"
      align="center"
      :class="userInfoPadding"
    >
      <v-sheet
        :width="userInfoWidth"
        color="baseColor"
      >
        <v-row>
          <v-col
            cols="12"
            class="d-flex justify-start align-center mt-5"
          >
            <AtomsUserIcon
              :icon-size="iconSize"
              :avatar-url="user.avatar_url"
            />
            <div>
              <AtomsUserName :user="user" />
            </div>
            <v-spacer />
            <div
              v-if="user.id !== loggedInUser.id"
              class="ml-3"
            >
              <AtomsUserButtonFollow
                :logged-in-user="loggedInUser"
                :user="user"
              />
            </div>
          </v-col>
          <v-col
            v-if="user.introduction"
            cols="12"
          >
            <AtomsUserIntroduction :introduction="user.introduction" />
          </v-col>
          <v-col
            cols="12"
            class="text-center d-flex justify-start"
          >
            <AtomsUserStatusFollow
              :following-count="followingCount"
              :user-id="user.id"
            />
            <AtomsUserStatusFollower
              :followers-count="followersCount"
              :user-id="user.id"
            />
            <AtomsUserStatusLikes :liked-posts-count="likedPostsCount" />
          </v-col>
        </v-row>
      </v-sheet>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    followingCount: {
      type: Number,
      required: true,
    },
    followersCount: {
      type: Number,
      required: true,
    },
    likedPostsCount: {
      type: Number,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
  },
  computed: {
    userInfoWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '45%'
    },
    fontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '12px' } : { 'font-size': '16px' }
    },
    userInfoPadding () {
      return this.$vuetify.breakpoint.xs ? '' : 'px-10'
    },
  },
}
</script>
