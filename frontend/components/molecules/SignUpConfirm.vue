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
          入力確認
        </v-card-title>
        <v-card-text>
          <v-row align="center">
            <v-col cols="12">
              名前: {{ user.name }}
            </v-col>
            <v-col cols="12">
              メールアドレス: {{ user.email }}
            </v-col>
            <v-col cols="12">
              出身地: {{ user.birth_place }}
            </v-col>
            <v-col cols="12">
              生年月日: {{ user.birth_year }}年{{ user.birth_month }}月{{ user.birth_day }}日
            </v-col>
            <v-col cols="12">
              パスワード: {{ '*'.repeat(user.password.length) }}
            </v-col>
            <v-col cols="12">
              パスワード確認: {{ '*'.repeat(user.password_confirmation.length) }}
            </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-row>
            <v-col cols="3">
              <v-btn
                text
                plain
                @click="back"
              >
                前へ
              </v-btn>
            </v-col>
            <v-spacer />
            <v-col cols="3">
              <v-btn
                text
                plain
                @click="signUp"
              >
                登録する
              </v-btn>
            </v-col>
          </v-row>
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
    },
    cardWidth: {
      type: String,
      required: true,
    },
  },
  methods: {
    back () {
      this.$emit('back')
    },
    signUp () {
      this.$emit('sign-up')
    },
  },
}
</script>
