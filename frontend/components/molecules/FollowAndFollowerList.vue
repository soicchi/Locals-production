<template>
  <v-container fluid>
    <v-row
      justify="center"
      align="center"
    >
      <v-list
        :width="listWidth"
        class="follow-box"
        elevation="1"
      >
        <v-list-item-group class="d-flex justify-center text-center">
          <v-col cols="6">
            <AtomsUserButtonFollowing :user-id="user.id" />
          </v-col>
          <v-col cols="6">
            <AtomsUserButtonFollowers :user-id="user.id" />
          </v-col>
        </v-list-item-group>
        <template v-if="pathName">
          <v-list-item
            v-for="followedUser in user.following"
            :key="followedUser.id"
          >
            <v-col cols="6">
              <MoleculesUserFollowAndFollowerItem
                :user="followedUser"
                :icon-size="iconSize"
              />
            </v-col>
            <v-spacer />
            <v-col
              cols="6"
              class="d-flex justify-end"
            >
              <AtomsUserButtonFollow
                :user="followedUser"
                :logged-in-user="loggedInUser"
              />
            </v-col>
          </v-list-item>
        </template>
        <template v-else>
          <v-list-item
            v-for="followerUser in user.followers"
            :key="followerUser.id"
          >
            <v-col cols="6">
              <MoleculesUserFollowAndFollowerItem
                :user="followerUser"
                :icon-size="iconSize"
              />
            </v-col>
            <v-spacer />
            <v-col
              cols="6"
              class="d-flex justify-end"
            >
              <AtomsUserButtonFollow
                :user="followerUser"
                :logged-in-user="loggedInUser"
              />
            </v-col>
          </v-list-item>
        </template>
      </v-list>
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
    pathName: {
      type: Boolean,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
  },
  computed: {
    listWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '40%'
    },
  },
}
</script>
