<template>
  <el-container class="orderInfo">
    <el-header>
      <header class="header">
        <el-row type="flex">
          <el-col :span="6">
            <!-- 搜索区域 -->
            <el-input
              placeholder="请输入搜索用户姓名或手机号"
              v-model="queryInfo.information"
              clearable
              @clear="getOrderList"
            >
              <el-button
                slot="append"
                icon="el-icon-search"
                @click="getOrderList"
              ></el-button>
            </el-input>
          </el-col>
        </el-row>
      </header>
    </el-header>

    <el-main>
      <main class="main">
        <el-table ref="userTable" :data="orderList" border stripe>
          <el-table-column
            type="index"
            :index="indexMethod"
            label="序号"
            width="60px"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="寄件人"
            prop="consignor"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="寄件人号码"
            prop="consignor_phone"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="收件人"
            prop="consignee"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="收件人号码"
            prop="consignee_phone"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="货物"
            prop="good_name"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="价格(¥)"
            prop="good_price"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="状态"
            prop="good_state"
          ></el-table-column>
          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button
                type="primary is-plain"
                icon="el-icon-box"
                size="mini"
                @click="showOrderTrackDialog(scope.row.order_id)"
                >物流信息</el-button
              >
              <el-button
                type="primary is-plain"
                icon="el-icon-view"
                size="mini"
                @click="getGoodInfo(scope.row.order_id)"
                >商品信息</el-button
              >
              <el-button
                type="primary is-plain"
                icon="el-icon-delete"
                size="mini"
                @click="getGoodInfo(scope.row.order_id)"
                >删除订单</el-button
              >
            </template>
          </el-table-column>
        </el-table>
      </main>
    </el-main>

    <el-dialog
      class="OrderTrack"
      title="物流信息"
      center
      :visible.sync="orderTrackDialogVisible"
    >
      <div class="OrderRadio">
        查看方式：
        <el-radio-group v-model="reverse">
          <el-radio :label="true">倒序</el-radio>
          <el-radio :label="false">正序</el-radio>
        </el-radio-group>
      </div>
      <br/>
      <div class="OrderTrackBox">
        <el-timeline :reverse="reverse">
          <el-timeline-item
            v-for="(item, index) in orderTrack"
            :key="index"
            :icon="getIcon(index)"
            :color="getColor(index)"
            :timestamp="dateFormat(item.current_time)"
            placement="top"
          >
          <p v-if="index == 0">货物从{{ item.current_location }}出发</p>
          <p v-else>货物到达{{ item.current_location }}</p>
          </el-timeline-item>
        </el-timeline>
      </div>
    </el-dialog>

    <el-footer>
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="queryInfo.page"
        :page-sizes="[1, 2, 5, 10]"
        :page-size="queryInfo.size"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      ></el-pagination>
    </el-footer>
  </el-container>
</template>

<style scoped>
.el-footer {
  background: rgb(65, 61, 61);
}
.el-main {
  background: white;
}
.el-header {
  background: white;
}
.el-table {
  border-radius: 10px;
  /* margin-left: 30px; */
  margin-right: 30px;
}
.el-input {
  top: 10px;
  left: 30px;
}
.el-pagination {
  text-align: center;
}
</style>

<script>
export default {
  data () {
    return {
      isConsignor: true,
      orderList: [],
      queryInfo: {
        information: '',
        page: 1,
        size: 5
      },
      total: 0,
      orderTrackDialogVisible: false,
      orderTrack: [],
      reverse: false
    }
  },
  created () {
    // if (this.$route.query.user_id != null) {
    //   this.getUserOrder(this.$route.query.user_id)
    // }
    this.getOrderList()
  },
  methods: {
    async getOrderList () {
      await this.$http
        .post('/order/findAllOrder', this.queryInfo)
        .then((result) => {
          this.orderList = result.data.res
          this.total = result.data.total
          console.log(result)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    indexMethod (index) {
      return (this.queryInfo.page - 1) * this.queryInfo.size + 1 + index
    },
    handleSizeChange (newSize) {
      this.queryInfo.size = newSize
      this.getOrderList()
    },
    handleCurrentChange (newPage) {
      this.queryInfo.page = newPage
      this.getOrderList()
    },
    async getOrderTrack (id) {
      await this.$http
        .get('/order/findOrderTrack/' + id)
        .then((result) => {
          this.orderTrack = result.data.res
          console.log(result)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    showOrderTrackDialog (id) {
      console.log(id)
      this.getOrderTrack(id)
      this.orderTrackDialogVisible = true
    },
    getIcon (index) {
      var icon = ''
      if (index === 0) {
        icon = 'el-icon-s-flag'
      } else {
        icon = 'el-icon-check'
      }
      return icon
    },
    getColor (index) {
      var color = ''
      if (index === 0) {
        color = '#5C00FF'
      } else {
        color = '#67C23A'
      }
      return color
    },
    dateFormat (cellValue) {
      if (cellValue == null || cellValue === '') return ''
      let date = new Date(parseInt(cellValue)) // 时间戳为10位需*1000，如果为13位的话不需乘1000。
      let Y = date.getFullYear() + '-'
      let M =
        date.getMonth() + 1 < 10
          ? '0' + (date.getMonth() + 1) + '-'
          : date.getMonth() + 1 + '-'
      let D =
        date.getDate() < 10 ? '0' + date.getDate() + ' ' : date.getDate() + ' '
      let h =
        date.getHours() < 10
          ? '0' + date.getHours() + ':'
          : date.getHours() + ':'
      let m =
        date.getMinutes() < 10
          ? '0' + date.getMinutes() + ':'
          : date.getMinutes() + ':'
      let s =
        date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds()
      return Y + M + D + h + m + s
    }
  }
}
</script>
