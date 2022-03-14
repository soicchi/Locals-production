<template>
  <v-container
    fluid
    class="pt-12"
  >
    <v-row
      justify="center"
      align="center"
    >
      <v-card
        :width="cardWidth"
      >
        <v-card-title>
          評価ポイント
        </v-card-title>
        <v-card-subtitle>
          ※お店の良かったところは？
        </v-card-subtitle>
        <v-card-text>
          <v-row>
            <v-col
              v-for="list in evaluationList"
              :key="list.id"
              cols="4"
            >
              <v-checkbox
                v-model="setPost.taste_ids"
                :label="list.content"
                :value="list.id"
              />
            </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-btn
            text
            plain
            @click="back"
          >
            前へ
          </v-btn>
          <v-spacer />
          <v-btn
            text
            plain
            :disabled="post.taste_ids.length < 1"
            @click="createPost"
          >
            投稿する
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
      default: null,
    },
    evaluationList: {
      type: Array,
      required: true,
    },
    cardWidth: {
      type: String,
      required: true,
    },
    subPage: {
      type: Object,
      required: true,
    },
  },
  computed: {
    setPost: {
      get () { return this.post },
      set (newVal) { return this.$emit('update:post', newVal) },
    },
  },
  methods: {
    back () {
      this.$emit('back')
    },
    createPost () {
      this.$emit('create-post')
    },
  },
}
</script>
