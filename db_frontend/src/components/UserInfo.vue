<template>
  <el-container>
    <el-header>
      <header class="header">
        <el-row type="flex">
          <el-col :span="6">
           <el-input
            placeholder="请输入搜索的信息"
            v-model="queryInfo.information"
            clearable
            @clear="getUserList"
          >
            <el-button slot="append" icon="el-icon-search" @click="getUserList"
              >搜索</el-button
              >
          </el-input>
         </el-col>
        </el-row>
      </header>
    </el-header>

    <el-main>
      <main class="main">
        <el-table ref="userTable" :data="userList" border stripe>
          <el-table-column
            type="index"
            :index="indexMethod"
            label="序号"
            width="60px"
          ></el-table-column>
          <el-table-column label="用户名" prop="user_name"></el-table-column>
          <el-table-column label="用户号码" prop="user_phone"></el-table-column>
          <el-table-column
            label="用户性别"
            prop="user_gender"
          ></el-table-column>
          <!-- <el-table-column label="用户订单">
            <template slot-scope="scope">
              <el-button
                type="primary"
                icon="el-icon-view"
                size="mini"
                @click="getUserOrder(scope.row.user_id)"
                >查看用户订单</el-button
              >
            </template>
          </el-table-column> -->
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
}
.el-input {
  top: 10px;
  left: 30px;
}
.el-pagination{
    text-align: center;
}
</style>

<script>
export default {
  data () {
    return {
      isConsignor: true,
      ButtonInfo: '查看收件',
      userList: [],
      queryInfo: {
        information: '',
        page: 1,
        size: 5
      },
      total: 0
    }
  },
  created () {
    this.getUserList()
  },
  methods: {
    async getUserList () {
      await this.$http
        .post('/user/findAllUser', this.queryInfo)
        .then((result) => {
          this.userList = result.data.res
          this.total = result.data.total
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
      this.getUserList()
    },
    handleCurrentChange (newPage) {
      this.queryInfo.page = newPage
      this.getUserList()
    }
    // getUserOrder (id) {
    //   this.$router.push({
    //     path: '/order', query: {user_id: id}
    //   })
    // }
  }
}
</script>
