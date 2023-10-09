//
//  ItemNode.m
//  Sample
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
//  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ItemNode.h"

@implementation ItemNode

- (instancetype)initWithString:(NSString *)string
{
  self = [super init];
  
  if (self != nil) {
    self.text = string;
      self.textAttributes = @{
                              NSFontAttributeName: [UIFont systemFontOfSize:18.0],
                              NSForegroundColorAttributeName: [UIColor whiteColor],
                              };
    [self updateBackgroundColor];
  }
  
  return self;
}

- (void)updateBackgroundColor
{
  if (self.highlighted) {
    self.backgroundColor = [UIColor grayColor];
  } else if (self.selected) {
    self.backgroundColor = [UIColor darkGrayColor];
  } else {
    self.backgroundColor = [UIColor lightGrayColor];
  }
}

- (void)setSelected:(BOOL)selected
{
  [super setSelected:selected];
  
  [self updateBackgroundColor];
}

- (void)setHighlighted:(BOOL)highlighted
{
  [super setHighlighted:highlighted];
  
  [self updateBackgroundColor];
}
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    static CGFloat kInsets = 15.0;
    ASCenterLayoutSpec *center = [[ASCenterLayoutSpec alloc] init];
    center.centeringOptions = ASCenterLayoutSpecCenteringXY;
    center.child = self.textNode;
    UIEdgeInsets insets = UIEdgeInsetsMake(kInsets, kInsets, kInsets, kInsets);
    self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:center];
}
@end
