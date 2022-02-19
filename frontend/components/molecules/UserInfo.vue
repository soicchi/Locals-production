<template>
  <v-container fluid>
    <v-row>
      <v-col
        cols="12"
        class="d-flex justify-center mt-5"
      >
        <AtomsUserIcon
          :icon-size="iconSize"
          :avatar-url="user.avatar_url"
        />
      </v-col>
      <v-col
        cols="12"
        class="text-center"
      >
        <AtomsUserName :user="user" />
      </v-col>
      <template v-if="user.id !== loggedInUser.id">
        <v-col
          cols="12"
          class="d-flex justify-center"
        >
          <AtomsUserButtonFollow
            :logged-in-user="loggedInUser"
            :user="user"
          />
        </v-col>
      </template>
      <v-col
        v-if="user.introduction"
        cols="12"
        class="d-flex justify-center"
      >
        <AtomsUserIntroduction :introduction="user.introduction" />
      </v-col>
      <v-col
        cols="12"
        class="text-center"
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
}
</script>
