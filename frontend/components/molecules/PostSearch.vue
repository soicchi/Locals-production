<template>
  <v-row justify="center">
    <v-dialog
      v-model="dialog"
      max-width="600px"
    >
      <template #activator="{ on, attrs }">
        <v-btn
          color="subColor"
          class="search-btn pa-4"
          height="60"
          width="12%"
          v-bind="attrs"
          rounded
          v-on="on"
        >
          カテゴリー検索
        </v-btn>
      </template>
      <MoleculesModal>
        <template #modal-title>
          <AtomsFormTitle :title="title" />
        </template>
        <template #modal-content>
          <v-form
            v-model="setIsValid"
            class="d-flex align-center"
          >
            <v-col cols="7">
              <AtomsFormCategory
                :category-ids.sync="setCategoryIds"
                :category-items="categoryItems"
              />
            </v-col>
            <v-spacer />
            <v-col cols="3">
              <AtomsFormButtonSearch
                :loading="loading"
                :category-ids="categoryIds"
                @search="search"
              />
            </v-col>
            <v-col cols="3">
              <AtomsFormButtonSearchReset @reset="reset" />
            </v-col>
          </v-form>
        </template>
      </MoleculesModal>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: false,
    },
    categoryIds: {
      type: Array,
      required: true,
    },
    categoryItems: {
      type: Array,
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    isValid: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  data () {
    return {
      dialog: false,
    }
  },
  computed: {
    setCategoryIds: {
      get () { return this.categoryIds },
      set (newVal) { return this.$emit('update:category-ids', newVal) },
    },
    setIsValid: {
      get () { return this.isValid },
      set (newVal) { return this.$emit('update:is-valid', newVal) },
    },
  },
  methods: {
    search () {
      this.$emit('search')
    },
    reset () {
      this.$emit('reset')
    },
  },
}
</script>

<style lang="sass" scoped>
  .search-btn
    color: #fff
    font-size: 26px
</style>
