<template>
  <el-container class="orderInfo">
    <el-header>
      <header class="header">
        <el-row type="flex">
        <!-- <el-select
          v-model="selectType"
          placeholder="订单类型"
          @change="handleKindChange"
        >
          <el-option label="请选择收件类型" value=""></el-option>
          <el-option
            v-for="item in OrderType"
            :key="item"
            :label="item"
            :value="item"
          ></el-option>
        </el-select> -->

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
          <el-table-column label="寄件人" prop="consignor"></el-table-column>
          <el-table-column label="寄件人号码" prop="consignor_phone"></el-table-column>
          <el-table-column label="收件人" prop="consignee"></el-table-column>
          <el-table-column label="收件人号码" prop="consignee_phone"></el-table-column>
          <el-table-column label="货物" prop="good_name"></el-table-column>
          <el-table-column label="价格" prop="good_price"></el-table-column>
          <el-table-column label="状态" prop="good_state"></el-table-column>
          <el-table-column label="物流信息">
            <template slot-scope="scope">
              <el-button
                type="primary"
                icon="el-icon-view"
                size="mini"
                @click="findUserOrder(scope.row.user_id)"
                >查看物流</el-button
              >
            </template>
          </el-table-column>
        </el-table>
      </main>
    </el-main>

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
.el-pagination{
    text-align: center;
}
.orderInfo {
    background: rgb(145, 56, 56);
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
      selectType: '查看寄件',
      OrderType: ['查看寄件', '查看收件']
    }
  },
  created () {
    // if (this.$route.query.user_id != null) {
    //   this.getUserOrder(this.$route.query.user_id)
    // }
    this.getOrderList()
  },
  methods: {
    async getUserOrder (id) {
      await this.$http.get('/order/findAllOrder/' + id).then((result) => {
        this.orderList = result.data.res
        this.total = result.data.total
        console.log(result)
      }).catch((err) => {
        console.log(err)
      })
    },
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
    handleKindChange () {
      this.queryInfo.page = 1
      this.getOrderList()
    }
  }
}
</script>
