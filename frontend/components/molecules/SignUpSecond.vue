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
          飲食店に求めるものを選択
        </v-card-title>
        <v-card-subtitle>
          ※たくさん選択すればより正確なマッチ度が出ます
        </v-card-subtitle>
        <v-card-text>
          <v-row>
            <v-col
              v-for="list in preferenceList"
              :key="list.id"
              cols="4"
            >
              <v-checkbox
                v-model="setUser.taste_ids"
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
            :disabled="user.taste_ids.length < 3"
            @click="next"
          >
            次へ
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
      default: null,
    },
    preferenceList: {
      type: Array,
      required: true,
    },
    cardWidth: {
      type: String,
      required: true,
    },
  },
  computed: {
    setUser: {
      get () { return this.user },
      set (newVal) { return this.$emit('update:user', newVal) },
    },
  },
  methods: {
    back () {
      this.$emit('back')
    },
    next () {
      this.$emit('next')
    },
  },
}
</script>
