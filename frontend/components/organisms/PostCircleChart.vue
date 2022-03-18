<script>
import { Pie } from 'vue-chartjs'

export default {
  extends: Pie,
  data: () => ({
    favoriteData: {
      labels: ['〜10代', '20代', '30代', '40代', '50代', '60代〜'],
      datasets: [{
        label: 'いいね割合',
        data: [12, 11, 35, 2, 1, 39], // サンプルデータ
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 159, 64, 0.2)',
          'rgba(255, 205, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(54, 162, 235, 0.2)',
        ],
        borderColor: [
          'rgb(255, 99, 132)',
          'rgb(255, 159, 64)',
          'rgb(255, 205, 86)',
          'rgb(75, 192, 192)',
          'rgb(54, 162, 235)',
        ],
        borderWidth: 1,
      }],
    },
  }),
  mounted () {
    this.renderChart(this.favoriteData, this.chartOptions)
  },
}
</script>
