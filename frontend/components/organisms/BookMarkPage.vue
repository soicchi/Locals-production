<template>
  <div>
    <MoleculesPostCard
      v-for="post in bookMarkPosts"
      :key="post.id"
      :post="post"
      :logged-in-user="loggedInUser"
      :icon-size="iconSize"
      :post-title="postTitle"
    >
      <template #post-card-user-name>
        <AtomsUserName :user="post.user" />
      </template>
    </MoleculesPostCard>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      bookMarkPosts: 'bookMark/bookMarks',
      loggedInUser: 'user/loggedInUser',
    }),
    iconSize () {
      return 60
    },
    postTitle () {
      return '保存した投稿'
    },
  },
}
</script>
