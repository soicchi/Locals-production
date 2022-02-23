<script>
import { Bar } from 'vue-chartjs'

export default {
  extends: Bar,
  props: {
    favoriteRateGroup: {
      type: Array,
      required: true,
    },
  },
  data () {
    return {
      favoriteData: {
        labels: ['〜20代', '30代', '40代', '50代', '60代〜'],
        datasets: [{
          label: '年齢別いいね率',
          data: this.favoriteRateGroup,
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
      chartOptions: {
        scales: {
          yAxes: [
            {
              ticks: {
                min: 0,
                max: 100,
                stepSize: 10,
                callback: value => value + '%',
              },
            },
          ],
        },
      },
    }
  },
  mounted () {
    this.renderChart(this.favoriteData, this.chartOptions)
  },
}
</script>
