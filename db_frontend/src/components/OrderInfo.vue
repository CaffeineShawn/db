<template>
  <el-container class="orderInfo">
    <el-header>
      <header class="header">
        <el-row type="flex">
          <el-col :span="8">
            <!-- 搜索区域 -->
            <el-input
              style="top: 10px"
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
          <el-col>
            <el-button
              style="margin-left: 10px; margin-top: 10px"
              icon="el-icon-plus"
              @click="addOrderDialogVisible = true"
            >
              添加订单
            </el-button>
          </el-col>
        </el-row>
      </header>
    </el-header>

    <el-main>
      <main class="main">
        <el-table ref="orderTable" :data="orderList" border stripe>
          <el-table-column
            type="index"
            :index="indexMethod"
            label="序号"
            width="60px"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="寄件人"
            prop="consignor"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="寄件人号码"
            prop="consignor_phone"
          ></el-table-column>
          <el-table-column
            width="100px"
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
            width="80px"
            label="状态"
            prop="order_state"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="发货点"
            prop="order_origin"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="终点"
            prop="order_destination"
          ></el-table-column>
          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button
                type="primary is-plain"
                icon="el-icon-box"
                size="mini"
                @click="showorderTrackDialog(scope.row.order_id)"
                >物流信息</el-button
              >
              <el-button
                type="primary is-plain"
                icon="el-icon-view"
                size="mini"
                @click="showEditOrderDialog(scope.row.order_id)"
                >商品信息</el-button
              >
              <el-button
                type="primary is-plain"
                icon="el-icon-delete"
                size="mini"
                @click="deleteOrderById(scope.row.order_id)"
                >删除订单</el-button
              >
            </template>
          </el-table-column>
        </el-table>
      </main>
    </el-main>

    <el-dialog
      class="orderTrack"
      title="物流信息"
      center
      :visible.sync="orderTrackDialogVisible"
      width="30%"
    >
      <div class="TrackBox">
        查看方式:
        <el-radio-group v-model="reverse">
          <el-radio :label="true">倒序</el-radio>
          <el-radio :label="false">正序</el-radio>
        </el-radio-group>
        <el-divider></el-divider>
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
      <div></div>
    </el-dialog>

    <el-dialog
      class="OrderInfoBox"
      title="订单详情"
      width="30%"
      :visible.sync="editOrderInfoDialogVisible"
      @close="clearGoodInfo"
    >
    <div class="editOrderInfoBox" style="display: flex">
      <el-card class="goodInfoCard">
        <span>
          <el-form
            ref="existingGoodInfo"
            :model="goodInfo"
            label-width="100px"
            label-position="left"
          >
            <el-form-item label="商品名:" prop="good_name">
              <el-input
                type="textarea"
                v-model="goodInfo.good_name"
                placeholder="请输入商品名"
              ></el-input>
            </el-form-item>
            <el-form-item label="重量(kg):" prop="good_weight">
              <el-input
                type="textarea"
                v-model="goodInfo.good_weight"
                placeholder="请输入重量"
              ></el-input>
            </el-form-item>
            <el-form-item label="价格(¥):" prop="good_price">
              <el-input
                type="textarea"
                v-model="goodInfo.good_price"
                placeholder="请输入价格"
              ></el-input>
            </el-form-item>
          </el-form>
        </span>
      </el-card>
      <el-card>
        <span>
          <el-form
            ref="existingOrderInfo"
            :model="orderInfo"
            label-width="100px"
            label-position="left"
          >
            <el-form-item label="发货地点:" prop="order_origin">
              <el-input
                type="textarea"
                v-model="orderInfo.order_origin"
                placeholder="请输入发货地点"
              ></el-input>
            </el-form-item>
            <el-form-item label="目的地:" prop="order_destination">
              <el-input
                type="textarea"
                v-model="orderInfo.order_destination"
                placeholder="请输入目的地"
              ></el-input>
            </el-form-item>
            <el-form-item label="状态:" prop="order_state">
              <el-select v-model="orderInfo.order_state" placeholder="订单状态">
                <el-option
                  v-for="item in orderStateList"
                  :key="item"
                  :label="item"
                  :value="item"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-form>
        </span>
      </el-card>
    </div>
      <span slot="footer" class="goodInfoDialog-footer">
        <el-button type="primary" @click="goodInfoDialogVisible = false"
          >取 消</el-button
        >
        <el-button type="primary" @click="updateGoodInfo">修 改</el-button>
      </span>
    </el-dialog>

    <el-dialog
      class="addOrderBox"
      title="添加订单"
      :visible.sync="addOrderDialogVisible"
      @close="addOrderDialogClosed"
    >
      <div class="orderInfoBox" style="display: flex">
        <el-card class="consignorCard">
          <span>发件人信息</span>
          <el-divider></el-divider>
          <el-form
            ref="consignorInfo"
            :model="consignor"
            label-width="auto"
            label-position="left"
            :rules="rulesForUser"
          >
            <el-form-item label="发件人:" prop="user_name">
              <el-input
                type="textarea"
                v-model="consignor.user_name"
                placeholder="请输入发件人姓名"
              ></el-input>
            </el-form-item>
            <el-form-item label="手机号:" prop="user_phone">
              <el-input
                type="textarea"
                v-model="consignor.user_phone"
                placeholder="请输入发件人手机号"
              ></el-input>
            </el-form-item>
            <el-form-item label="地址:" prop="user_address">
              <el-input
                type="textarea"
                v-model="consignor.user_address"
                placeholder="请输入发件人地址"
              ></el-input>
            </el-form-item>
          </el-form>
        </el-card>
        <el-card class="consigneeCard">
          <span>收件人信息</span>
          <el-divider></el-divider>
          <el-form
            ref="consigneeInfo"
            :model="consignee"
            label-width="auto"
            label-position="left"
            :rules="rulesForUser"
          >
            <el-form-item label="收件人:" prop="user_name">
              <el-input
                type="textarea"
                v-model="consignee.user_name"
                placeholder="请输入收件人姓名"
              ></el-input>
            </el-form-item>
            <el-form-item label="手机号:" prop="user_phone">
              <el-input
                type="textarea"
                v-model="consignee.user_phone"
                placeholder="请输入收件人手机号"
              ></el-input>
            </el-form-item>
            <el-form-item label="地址:" prop="user_address">
              <el-input
                type="textarea"
                v-model="consignee.user_address"
                placeholder="请输入收件人地址"
              ></el-input>
            </el-form-item>
          </el-form>
        </el-card>
        <el-card class="goodCard">
          <span>货物信息</span>
          <el-divider></el-divider>
          <el-form
            ref="goodInfo"
            :model="goodInfo"
            label-width="auto"
            label-position="left"
            :rules="rulesForGood"
          >
            <el-form-item label="货物名:" prop="good_name">
              <el-input
                type="textarea"
                v-model="goodInfo.good_name"
                placeholder="请输入货物名称"
              ></el-input>
            </el-form-item>
            <el-form-item label="货物重量:" prop="good_weight">
              <el-input
                type="textarea"
                v-model="goodInfo.good_weight"
                placeholder="请输入货物重量(kg)"
                @keyup.native="check('weight')"
              ></el-input>
            </el-form-item>
            <el-form-item label="货物价格:" prop="good_price">
              <el-input
                type="textarea"
                v-model="goodInfo.good_price"
                placeholder="请输入货物价格(¥)"
                @keyup.native="check('price')"
              ></el-input>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
      <span slot="footer">
        <el-button type="primary" @click="addOrderDialogVisible = false"
          >取 消</el-button
        >
        <el-button type="primary" @click="addOrder">确 定</el-button>
      </span>
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
.el-pagination {
  text-align: center;
}
.TrackBox {
  width: 15vw;
}
.consignorCard {
  background: rgb(122, 170, 150, 0.7);
}
.consigneeCard {
  background: rgb(141, 169, 182, 0.7);
  margin-left: 15px;
}
.goodCard {
  background: rgb(182, 141, 141, 0.7);
  margin-left: 15px;
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
      editOrderInfoDialogVisible: false,
      orderTrack: [],
      reverse: false,
      goodInfo: {},
      orderInfo: {},
      consignor: {},
      consignee: {},
      orderStateList: ['待发货', '已发货', '已送达'],
      addOrderDialogVisible: false,
      rulesForUser: {
        user_name: [
          {
            required: true,
            message: '请输入用户姓名',
            trigger: 'blur'
          },
          {
            max: 30,
            message: '用户名的描述最长为30个字符',
            trigger: 'blur'
          }
        ],
        user_phone: [
          {
            required: true,
            message: '请输入手机号',
            trigger: 'blur'
          },
          {
            pattern: /^1[3456789]\d{9}$/,
            message: '手机格式错误',
            trigger: 'change'
          }
        ],
        user_address: [
          {
            required: true,
            message: '请输入地址',
            trigger: 'blur'
          },
          {
            max: 254,
            message: '地址过长',
            trigger: 'change'
          }
        ]
      },
      rulesForGood: {
        good_name: [
          {
            required: true,
            message: '请输入货物姓名',
            trigger: 'blur'
          },
          {
            max: 30,
            message: '货物名的描述最长为30个字符',
            trigger: 'blur'
          }
        ],
        good_weight: [
          {
            required: true,
            message: '请输入货物重量',
            trigger: 'blur'
          }
        ],
        good_price: [
          {
            required: true,
            message: '请输入货物价格',
            trigger: 'blur'
          }
        ]
      }
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
    async getorderTrack (id) {
      await this.$http
        .get('/order/findOrderTrack/' + id)
        .then((result) => {
          this.orderTrack = result.data.res
        })
        .catch((err) => {
          console.log(err)
        })
    },
    async getgoodInfo (id) {
      await this.$http
        .get('/good/findGoodById/' + id)
        .then((result) => {
          this.goodInfo = result.data.res
          console.log(result)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    async getOrderInfo (id) {
      await this.$http
        .get('/order/findOrderById/' + id)
        .then((result) => {
          this.orderInfo = result.data.res
          console.log(result)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    async deleteOrderById (id) {
      const confirmRes = await this.$confirm(
        '确认删除该订单？该操作不可逆',
        '提示',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }
      ).catch((err) => err)
      if (confirmRes !== 'confirm') return this.$message.info('已取消删除')
      await this.$http
        .delete('/order/deleteOrderById/' + id)
        .then((result) => {
          if (result.data === 'ok') {
            this.$message.success('删除成功')
            this.getOrderList()
          } else {
            this.$message.success('删除异常')
            this.getOrderList()
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    addOrder () {
      this.$refs.consignorInfo.validate((valid) => {
        if (valid) {
          this.$refs.consigneeInfo.validate((valid) => {
            if (valid) {
              this.$refs.goodInfo.validate(async (valid) => {
                if (valid) {
                  var orderInfo = {
                    consignor: this.consignor,
                    consignee: this.consignee,
                    goodInfo: this.goodInfo,
                    orderInfo: {
                      order_origin: this.consignor.user_address,
                      order_destination: this.consignee.user_address
                    }
                  }
                  console.log(orderInfo)
                  await this.$http
                    .post('/order/addOrder', orderInfo)
                    .then((result) => {
                      if (result.data === 'ok') {
                        this.$message.success('添加成功')
                        this.getOrderList()
                        this.addOrderDialogVisible = false
                      } else {
                        this.$message.error('添加异常')
                      }
                    })
                    .catch((err) => {
                      console.log(err)
                    })
                } else {
                  return this.$message.error('货物信息未完善或错误')
                }
              })
            } else {
              return this.$message.error('收件人信息未完善或错误')
            }
          })
        } else {
          return this.$message.error('发件人信息未完善或错误')
        }
      })
    },
    async updateGoodInfo () {
      await this.$http
        .put('good/updateGoodInfo', this.goodInfo)
        .then((result) => {
          if (result.data === 'ok') {
            this.$message.success('修改成功')
            this.getOrderList()
            this.goodInfoDialogVisible = false
          } else {
            this.$message.error('修改失败')
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    showorderTrackDialog (id) {
      this.getorderTrack(id)
      this.orderTrackDialogVisible = true
    },
    showEditOrderDialog (id) {
      this.getgoodInfo(id)
      this.getOrderInfo(id)
      this.editOrderInfoDialogVisible = true
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
    },
    check (type) {
      var data = ''
      if (type === 'price') {
        data = data + this.goodInfo.good_price
      } else {
        data = data + this.goodInfo.good_weight
      }
      data = data
        .replace(/[^\d.]/g, '') // 清除“数字”和“.”以外的字符
        .replace(/\.{2,}/g, '.') // 只保留第一个. 清除多余的
        .replace('.', '$#$')
        .replace(/\./g, '')
        .replace('$#$', '.')
        .replace(/^(-)*(\d+)\.(\d\d).*$/, '$1$2.$3') // 只能输入两个小数
      if (data.indexOf('.') < 0 && data !== '') {
        // 以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
        data = parseFloat(data)
      }
      if (type === 'price') {
        this.goodInfo.good_price = data
      } else {
        this.goodInfo.good_weight = data
      }
    },
    addOrderDialogClosed () {
      this.$refs.consignorInfo.resetFields()
      this.$refs.consigneeInfo.resetFields()
      this.$refs.goodInfo.resetFields()
    },
    clearGoodInfo () {
      this.goodInfo = {}
    }
  }
}
</script>
